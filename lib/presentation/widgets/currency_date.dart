import 'package:crypto_pair_app/logic/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_pair_app/logic/order_book_bloc/orderbook_bloc.dart';
import 'package:crypto_pair_app/presentation/widgets/order_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class CurrencyData extends StatelessWidget {
  const CurrencyData({
    Key? key,
    required this.tickerID,
    required this.timeStamp,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.lastPrice,
    required this.volume,
  }) : super(key: key);
  final String tickerID;
  final DateTime timeStamp;
  final String openPrice;
  final String highPrice;
  final String lowPrice;
  final String lastPrice;
  final String volume;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tickerID.toUpperCase(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(DateFormat().format(timeStamp)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tickerDataTile(title: 'open', value: openPrice),
              _tickerDataTile(title: 'high', value: highPrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _tickerDataTile(title: 'low', value: lowPrice),
              _tickerDataTile(title: 'last', value: lastPrice),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _tickerDataTile(title: 'volume', value: volume),
            ],
          ),
          BlocConsumer<OrderbookBloc, OrderbookState>(
            listener: (context, state) {
              if (state is FetchOrderBookFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load Order Book')));
              }
            },
            builder: (context, state) {
              if (state is OrderBookLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FetchOrderBookSuccessfull) {
                return Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          context
                              .read<OrderbookBloc>()
                              .add(ResetOrderBookStateRequested());
                        },
                        child: const Text(
                          'HIDE ORDER BOOK',
                        )),
                    OrderBookWidget(
                      asks: state.orderBook.asks,
                      bids: state.orderBook.bids,
                    ),
                  ],
                );
              }
              return TextButton(
                  onPressed: () {
                    context
                        .read<OrderbookBloc>()
                        .add(LoadOrderBookRequested(tickerID));
                  },
                  child: const Text(
                    'VIEW ORDER BOOK',
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget _tickerDataTile({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase()),
          Text(
            '\$ $value',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
