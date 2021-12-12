import 'package:crypto_pair_app/logic/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_pair_app/logic/order_book_bloc/orderbook_bloc.dart';
import 'package:crypto_pair_app/presentation/widgets/currency_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FloatingSearchBarController _floatingSearchBarController =
      FloatingSearchBarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            renderTickerResult(),
            buildFloatingSearchBar(),
          ],
        ));
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
        hint: 'Search...',
        automaticallyImplyBackButton: false,
        controller: _floatingSearchBarController,
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 300),
        transitionCurve: Curves.easeInOut,
        clearQueryOnClose: false,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 200),
        transition: CircularFloatingSearchBarTransition(),
        onSubmitted: (query) {
          context
              .read<CryptoBloc>()
              .add(CryptoTickerSearched(_floatingSearchBarController.query));
          context.read<OrderbookBloc>().add((ResetOrderBookStateRequested()));
          _floatingSearchBarController.close();
        },
        actions: [
          const FloatingSearchBarAction(
            showIfOpened: false,
            child: Icon(Icons.search),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return const SizedBox();
        });
  }

  Widget renderTickerResult() {
    return BlocConsumer<CryptoBloc, CryptoState>(
      listener: (context, state) {
        if (state is FetchingTickerDataFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to load data')));
        } else if (state is UnsupportedTicker) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.tickerId} wont be supported')));
        }
      },
      builder: (context, state) {
        if (state is TickerDateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FetchingTickerDataSuccessfull) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CurrencyData(
                  tickerID: state.tickerId,
                  timeStamp: state.ticker.timeStamp,
                  openPrice: state.ticker.openPrice,
                  highPrice: state.ticker.highPrice,
                  lowPrice: state.ticker.lowPrice,
                  lastPrice: state.ticker.lastPrice,
                  volume: state.ticker.volume,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<CryptoBloc>().add(CryptoTickerSearched(
                          _floatingSearchBarController.query));
                    },
                    child: const Icon(Icons.refresh),
                  ),
                )
              ],
            ),
          );
        }
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.search,
                size: 100,
                color: Colors.black38,
              ),
              Text('Enter a currency pair to load data'),
            ],
          ),
        );
      },
    );
  }
}
