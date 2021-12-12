import 'package:crypto_pair_app/presentation/screens/home.dart';
import 'package:crypto_pair_app/utils/router_config.dart';
import 'package:flutter/material.dart';

class RouterServices {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> getNavigatorKey() => navigatorKey;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterConfig.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}
