import 'package:flutter/material.dart';

import '../base/base_service.dart';

class NavigationService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    log!.i('navigateToPage: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log!.e('navigateToPage: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState?.push(pageRoute);
  }

  Future<T?> navigateToPageAndRemoveUntil<T>(
      MaterialPageRoute<T> pageRoute, RoutePredicate predicate) async {
    log!.i(
        'navigateToPageAndRemoveUntil: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log!.e('navigateToPageAndRemoveUntil: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState?.pushAndRemoveUntil(pageRoute, predicate);
  }

  Future<T?>? pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    log!.i('pushNamed: routeName: $routeName');
    if (navigatorKey.currentState == null) {
      log!.e('pushNamed: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState
        ?.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> navigateToPageAndRemoveUntilAll<T>(
      MaterialPageRoute<T> pageRoute, RoutePredicate predicate) async {
    log!.i(
        'navigateToPageAndRemoveUntilAll: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log!.e('navigateToPageAndRemoveUntilAll: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState?.pushAndRemoveUntil(pageRoute, predicate);
  }

  Future<T?> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    log!.i('navigateToPageWithReplacement: '
        'pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log!.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState?.pushReplacement(pageRoute);
  }

  Future<T?> navigateToPushReplacementNamed<T>(String routeName,
      {Object? arguments}) async {
    log!.i('navigateToPushReplacementNamed: routeName: $routeName');
    if (navigatorKey.currentState == null) {
      log!.e('navigateToPushReplacementNamed: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop<T>([T? result]) {
    log!.i('goBack:');
    if (navigatorKey.currentState == null) {
      log!.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState?.pop(result);
  }
}
