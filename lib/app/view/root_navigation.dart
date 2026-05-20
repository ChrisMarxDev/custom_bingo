import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:flutter/material.dart';

/// Root navigator key — used by share-link handling and app-level toast helpers.
final rootNavigatorKey = GlobalKey<NavigatorState>();

final routeContextObserver = RouteContextObserver();

class RouteContextObserver extends NavigatorObserver {
  BuildContext? currentContext;

  void _track(Route<dynamic>? route) {
    if (route case ModalRoute<dynamic> modalRoute) {
      final subtreeContext = modalRoute.subtreeContext;
      if (subtreeContext != null) {
        currentContext = subtreeContext;
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final nextContext = modalRoute.subtreeContext;
        if (nextContext != null && nextContext.mounted) {
          currentContext = nextContext;
        }
      });
      return;
    }

    currentContext = null;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _track(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _track(previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _track(previousRoute);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _track(newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

void showRootNeutralToast(String message, [int attemptsRemaining = 2]) {
  _showRootToast(
    attemptsRemaining,
    (context) => showNeutralToast(context, message),
  );
}

void showRootErrorToast(String message, [int attemptsRemaining = 2]) {
  _showRootToast(
    attemptsRemaining,
    (context) => showErrorToast(context, message),
  );
}

void _showRootToast(
  int attemptsRemaining,
  void Function(BuildContext context) showToast,
) {
  final toastContext = routeContextObserver.currentContext;
  if (toastContext != null && toastContext.mounted) {
    showToast(toastContext);
    return;
  }
  if (attemptsRemaining == 0) return;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _showRootToast(attemptsRemaining - 1, showToast);
  });
}
