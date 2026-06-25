import 'package:custom_bingo/common/services/user_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:state_beacon/state_beacon.dart';

const revenueCatIosApiKey = 'appl_ygcZivPvGFbMTHCrwZezbPVaLDY';
const revenueCatAndroidApiKey = 'goog_sQfDdrGZswghIStnVtuRoSPVVEe';
const revenueCatWebApiKey = '';
const revenueCatEntitlementId = 'pro';
const revenueCatOfferingId = 'default';
const revenueCatPackageId = '';
const revenueCatLifetimeProductId = 'lifetime';
// Future donation tiers: when the 5, 10, and 15 euro SKUs are ready, surface
// them as separate products in the offering. Every SKU should be attached to
// the `pro` entitlement in RevenueCat so entitlement checks stay authoritative.

final revenueCatStateBeacon = Beacon.writable<RevenueCatState>(
  const RevenueCatState(
    status: RevenueCatStatus.unavailable,
    message: 'RevenueCat is not configured for this platform.',
  ),
);

enum RevenueCatStatus { unavailable, configuring, configured, error }

class RevenueCatState {
  const RevenueCatState({
    required this.status,
    this.customerInfo,
    this.message,
  });

  final RevenueCatStatus status;
  final CustomerInfo? customerInfo;
  final String? message;

  bool get isConfigured => status == RevenueCatStatus.configured;

  bool get hasProAccess {
    final info = customerInfo;
    if (info == null) return false;

    return hasRevenueCatProAccess(info);
  }

  RevenueCatState copyWith({
    RevenueCatStatus? status,
    CustomerInfo? customerInfo,
    String? message,
  }) {
    return RevenueCatState(
      status: status ?? this.status,
      customerInfo: customerInfo ?? this.customerInfo,
      message: message,
    );
  }
}

class RevenueCatPurchaseOption {
  const RevenueCatPurchaseOption._({required this.storeProduct, this.package});

  factory RevenueCatPurchaseOption.package(Package package) {
    return RevenueCatPurchaseOption._(
      package: package,
      storeProduct: package.storeProduct,
    );
  }

  factory RevenueCatPurchaseOption.storeProduct(StoreProduct storeProduct) {
    return RevenueCatPurchaseOption._(storeProduct: storeProduct);
  }

  final Package? package;
  final StoreProduct storeProduct;

  String get identifier => storeProduct.identifier;
  String get title => storeProduct.title;
  String get description => storeProduct.description;
  String get priceString => storeProduct.priceString;
}

class RevenueCatException implements Exception {
  const RevenueCatException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

class RevenueCatPurchaseCancelled extends RevenueCatException {
  const RevenueCatPurchaseCancelled([Object? cause])
    : super('Purchase cancelled.', cause);
}

var _configured = false;
var _listenerAttached = false;

Future<void> configureRevenueCat() async {
  final apiKey = _apiKeyForCurrentPlatform();

  if (apiKey.isEmpty) {
    revenueCatStateBeacon.value = RevenueCatState(
      status: RevenueCatStatus.unavailable,
      message: _configurationMessageForCurrentPlatform(),
    );
    return;
  }

  if (_configured) {
    await refreshRevenueCatCustomerInfo();
    return;
  }

  revenueCatStateBeacon.value = revenueCatStateBeacon.value.copyWith(
    status: RevenueCatStatus.configuring,
  );

  try {
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.info);
    final configuration = PurchasesConfiguration(apiKey)
      ..appUserID = userIdBeacon.value;
    await Purchases.configure(configuration);

    _configured = true;
    if (!_listenerAttached) {
      Purchases.addCustomerInfoUpdateListener(_handleCustomerInfoUpdate);
      _listenerAttached = true;
    }

    await refreshRevenueCatCustomerInfo();
  } on Object catch (error) {
    revenueCatStateBeacon.value = RevenueCatState(
      status: RevenueCatStatus.error,
      message: _messageFrom(error),
    );
  }
}

Future<void> refreshRevenueCatCustomerInfo() async {
  if (!_configured) return;

  try {
    _handleCustomerInfoUpdate(await Purchases.getCustomerInfo());
  } on Object catch (error) {
    revenueCatStateBeacon.value = revenueCatStateBeacon.value.copyWith(
      status: RevenueCatStatus.error,
      message: _messageFrom(error),
    );
  }
}

Future<RevenueCatPurchaseOption?> fetchRevenueCatLifetimeOption() async {
  _assertConfigured();

  try {
    final offerings = await Purchases.getOfferings();
    final selectedOffering = revenueCatOfferingId.isEmpty
        ? offerings.current
        : offerings.getOffering(revenueCatOfferingId) ?? offerings.current;

    Package? package;
    if (selectedOffering != null) {
      if (revenueCatPackageId.isNotEmpty) {
        package = selectedOffering.getPackage(revenueCatPackageId);
      }
      package ??= selectedOffering.lifetime;
      package ??= _findPackage(selectedOffering.availablePackages);

      if (package != null) {
        return RevenueCatPurchaseOption.package(package);
      }
    }

    if (kIsWeb) return null;

    final products = await Purchases.getProducts([
      revenueCatLifetimeProductId,
    ], productCategory: ProductCategory.nonSubscription);
    if (products.isEmpty) {
      _handleRevenueCatError(
        const RevenueCatException(
          'No purchase option is available for this app build.',
        ),
      );
      return null;
    }

    return RevenueCatPurchaseOption.storeProduct(products.first);
  } on PlatformException catch (error) {
    final exception = _exceptionFrom(error);
    _handleRevenueCatError(exception);
    throw exception;
  } on Object catch (error) {
    final exception = RevenueCatException(_messageFrom(error), error);
    _handleRevenueCatError(exception);
    throw exception;
  }
}

Future<CustomerInfo> purchaseRevenueCatOption(
  RevenueCatPurchaseOption option,
) async {
  _assertConfigured();

  try {
    final package = option.package;
    final result = package != null
        ? await Purchases.purchase(PurchaseParams.package(package))
        : await Purchases.purchase(
            PurchaseParams.storeProduct(option.storeProduct),
          );
    _handleCustomerInfoUpdate(result.customerInfo);
    return result.customerInfo;
  } on PlatformException catch (error) {
    throw _exceptionFrom(error);
  } on Object catch (error) {
    throw RevenueCatException(_messageFrom(error), error);
  }
}

Future<CustomerInfo> restoreRevenueCatPurchases() async {
  _assertConfigured();

  try {
    final customerInfo = await Purchases.restorePurchases();
    _handleCustomerInfoUpdate(customerInfo);
    return customerInfo;
  } on PlatformException catch (error) {
    throw _exceptionFrom(error);
  } on Object catch (error) {
    throw RevenueCatException(_messageFrom(error), error);
  }
}

bool hasRevenueCatProAccess(CustomerInfo customerInfo) {
  return customerInfo.entitlements.active[revenueCatEntitlementId]?.isActive ??
      false;
}

Package? _findPackage(List<Package> packages) {
  for (final package in packages) {
    if (package.identifier == revenueCatLifetimeProductId ||
        package.storeProduct.identifier == revenueCatLifetimeProductId) {
      return package;
    }
  }

  return packages.length == 1 ? packages.first : null;
}

void _assertConfigured() {
  if (!_configured) {
    throw RevenueCatException(_configurationMessageForCurrentPlatform());
  }
}

void _handleCustomerInfoUpdate(CustomerInfo customerInfo) {
  revenueCatStateBeacon.value = RevenueCatState(
    status: RevenueCatStatus.configured,
    customerInfo: customerInfo,
  );
}

void _handleRevenueCatError(RevenueCatException error) {
  revenueCatStateBeacon.value = revenueCatStateBeacon.value.copyWith(
    status: RevenueCatStatus.error,
    message: error.message,
  );
}

RevenueCatException _exceptionFrom(PlatformException error) {
  final code = _errorCodeFrom(error);

  if (code == PurchasesErrorCode.purchaseCancelledError) {
    return RevenueCatPurchaseCancelled(error);
  }

  return RevenueCatException(_messageFrom(error), error);
}

String _messageFrom(Object error) {
  if (error is RevenueCatException) return error.message;
  if (error is PlatformException) {
    final code = _errorCodeFrom(error);
    if (code == PurchasesErrorCode.configurationError) {
      return 'Purchases are not available yet. The store product is not '
          'available for this app build.';
    }
    return error.message ?? 'RevenueCat returned an unknown error.';
  }
  return 'RevenueCat returned an unknown error.';
}

PurchasesErrorCode? _errorCodeFrom(PlatformException error) {
  try {
    return PurchasesErrorHelper.getErrorCode(error);
  } on Object {
    return null;
  }
}

String _apiKeyForCurrentPlatform() {
  if (kIsWeb) return revenueCatWebApiKey;

  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS => revenueCatIosApiKey,
    TargetPlatform.android => revenueCatAndroidApiKey,
    _ => '',
  };
}

String _configurationMessageForCurrentPlatform() {
  if (kIsWeb) {
    return 'RevenueCat purchases are not configured for web.';
  }

  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS =>
      'Set REVENUECAT_IOS_API_KEY to enable purchases on iOS.',
    TargetPlatform.android =>
      'Set REVENUECAT_ANDROID_API_KEY to enable purchases on Android.',
    _ => 'RevenueCat purchases are not supported on this platform.',
  };
}
