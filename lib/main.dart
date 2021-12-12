import 'package:crypto_pair_app/data/model/order_book.dart';
import 'package:crypto_pair_app/data/repository/ticker_repositroy.dart';
import 'package:crypto_pair_app/logic/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_pair_app/logic/order_book_bloc/orderbook_bloc.dart';
import 'package:crypto_pair_app/services/router_services.dart';
import 'package:crypto_pair_app/utils/locator.dart';
import 'package:crypto_pair_app/utils/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return RepositoryProvider(
      create: (context) => TickerRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CryptoBloc(context.read<TickerRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                OrderbookBloc(context.read<TickerRepository>()),
          )
        ],
        child: MaterialApp(
          title: 'Crypto pair app',
          navigatorKey: navigatorKey,
          onGenerateRoute: RouterServices.generateRoute,
          initialRoute: RouterConfig.home,
        ),
      ),
    );
  }
}
