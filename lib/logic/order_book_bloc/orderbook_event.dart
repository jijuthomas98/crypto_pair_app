part of 'orderbook_bloc.dart';

abstract class OrderbookEvent extends Equatable {
  const OrderbookEvent();

  @override
  List<Object> get props => [];
}

class LoadOrderBookRequested extends OrderbookEvent {
  const LoadOrderBookRequested(this.tickerId);
  final String tickerId;
}

class ResetOrderBookStateRequested extends OrderbookEvent {}
