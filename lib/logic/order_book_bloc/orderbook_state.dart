part of 'orderbook_bloc.dart';

abstract class OrderbookState extends Equatable {
  const OrderbookState();

  @override
  List<Object> get props => [];
}

class OrderbookInitial extends OrderbookState {}

class OrderBookLoading extends OrderbookState {}

class FetchOrderBookFailed extends OrderbookState {}

class FetchOrderBookSuccessfull extends OrderbookState {
  const FetchOrderBookSuccessfull(this.orderBook);
  final OrderBook orderBook;
}
