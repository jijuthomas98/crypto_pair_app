import 'package:crypto_pair_app/data/model/order_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class OrderBookWidget extends StatefulWidget {
  const OrderBookWidget({Key? key, required this.asks, required this.bids})
      : super(key: key);
  final List<Asks> asks;
  final List<Bids> bids;

  @override
  State<OrderBookWidget> createState() => _OrderBookWidgetState();
}

class _OrderBookWidgetState extends State<OrderBookWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          const Text(
            'ORDER BOOK',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'BID PRICE',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('QTY',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('QTY',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('ASK PRICE',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    padding: const EdgeInsets.only(top: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.bids[index].bidPrice),
                            Text(widget.bids[index].quantity),
                            Text(widget.asks[index].quantity),
                            Text(widget.asks[index].askPrice)
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
