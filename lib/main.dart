import 'package:crypto_pair_app/services/router_services.dart';
import 'package:crypto_pair_app/utils/locator.dart';
import 'package:crypto_pair_app/utils/router_config.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(const AppRunner());
}

class AppRunner extends StatelessWidget {
  const AppRunner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey =
        locator<RouterServices>().getNavigatorKey();
    return MaterialApp(
      title: 'Crypto pair app',
      navigatorKey: navigatorKey,
      onGenerateRoute: RouterServices.generateRoute,
      initialRoute: RouterConfig.home,
    );
  }
}
