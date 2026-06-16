# Android Purchase Setup

This app is already wired for Android purchases in Flutter:

- `purchases_flutter` is installed.
- `android/app/src/main/AndroidManifest.xml` includes `com.android.vending.BILLING`.
- RevenueCat is configured on startup from `lib/common/services/revenue_cat_service.dart`.
- The Android RevenueCat API key is set.

The app expects these RevenueCat / Google Play values:

- Android package name: `de.christophermarx.bingo.custom_bingo`
- Entitlement ID: `pro`
- Offering ID: `default`
- Lifetime product ID: `lifetime`
- Product category: non-subscription

Creating the Google Play product and adding it to RevenueCat is necessary, but not enough by itself. Android testing also depends on Google Play Console tester setup, package-name matching, product activation, and RevenueCat's Google Play service credentials.

## Setup Checklist

1. In Google Play Console, create or verify an in-app product with product ID `lifetime`.
2. In RevenueCat, attach the Android product to entitlement `pro`.
3. Add the product to offering `default`.
4. Configure the RevenueCat Android product as non-consumable. Otherwise RevenueCat may consume it and Google Play can allow the user to buy it again.
5. In RevenueCat, verify Google Play service credentials are configured for the Android app.
6. In Google Play Console, add the tester Google account under license testing.
7. Add the same tester account to the internal or closed testing track.
8. Open the track opt-in URL while signed in as the tester account.
9. Make the test release available in the tester's country/region.
10. Use a real Android device when possible. If using an emulator, it must have Google Play Services.

## Build For Play Testing

Build the production Android App Bundle:

```bash
task build:android
```

Upload the generated production AAB to a Google Play internal or closed testing track.

Important: test the production package name, `de.christophermarx.bingo.custom_bingo`. The staging and development flavors use package suffixes and will not see the same Play products unless separate Play Console apps/products exist for those package names.

## Local Test Run

After the Play test track and product setup exist, you can run the production flavor locally:

```bash
flutter run --flavor production --target lib/main_production.dart
```

Then open the paywall and start the lifetime purchase flow.

Expected result:

- Google Play purchase sheet appears.
- The tester sees Google's test payment method.
- Purchase completes without charging a real card.
- RevenueCat receives the sandbox transaction.
- The customer gets active `pro` entitlement access.

In RevenueCat, enable the sandbox data view when checking for the transaction.

## Common Failures

Product does not load:

- Package name does not match the Play Console app.
- Tester did not open the opt-in URL.
- Tester is not added to the test track.
- Tester is not added under license testing.
- Product is not active in Google Play.
- Google Play changes have not propagated yet.
- RevenueCat offering/product mapping is wrong.

Purchase sheet does not appear:

- Device is signed into multiple Google accounts.
- The tester account is not the primary Play account on the device.
- Device is missing Google Play Services.
- Test release is not available in the tester's country/region.

Purchase succeeds but pro access is missing:

- Product is not attached to entitlement `pro`.
- Product is not included in offering `default`.
- RevenueCat Google Play service credentials are incomplete.
- The transaction was made outside RevenueCat tracking.

Lifetime product can be purchased repeatedly:

- Product is configured as consumable instead of non-consumable in RevenueCat.

## References

- RevenueCat Android sandbox testing: https://www.revenuecat.com/docs/test-and-launch/sandbox/google-play-store
- RevenueCat Google Play product setup: https://www.revenuecat.com/docs/getting-started/entitlements/android-products
- RevenueCat Google Play service credentials: https://www.revenuecat.com/docs/service-credentials/creating-play-service-credentials
- Google Play Billing testing: https://developer.android.com/google/play/billing/test
