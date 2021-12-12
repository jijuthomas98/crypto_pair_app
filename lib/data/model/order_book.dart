import 'package:equatable/equatable.dart';

class OrderBook extends Equatable {
  const OrderBook({
    required this.bids,
    required this.asks,
  });
  final List<Bids> bids;
  final List<Asks> asks;

  static OrderBook fromJson(Map<String, dynamic> json) {
    return OrderBook(
      bids: (json['bids'] as List).map((e) => Bids.fromList(e)).toList(),
      asks: (json['asks'] as List).map((e) => Asks.fromList(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [bids, asks];
}

class Bids extends Equatable {
  const Bids({required this.bidPrice, required this.quantity});
  final String bidPrice;
  final String quantity;

  static Bids fromList(List bidsList) {
    return Bids(bidPrice: bidsList[0], quantity: bidsList[1]);
  }

  @override
  List<Object?> get props => [bidPrice, quantity];
}

class Asks extends Equatable {
  const Asks({required this.askPrice, required this.quantity});
  final String askPrice;
  final String quantity;

  static Asks fromList(List asksList) {
    return Asks(askPrice: asksList[0], quantity: asksList[1]);
  }

  @override
  List<Object?> get props => [askPrice, quantity];
}
