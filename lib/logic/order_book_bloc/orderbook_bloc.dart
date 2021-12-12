import 'package:bloc/bloc.dart';
import 'package:crypto_pair_app/data/model/order_book.dart';
import 'package:crypto_pair_app/data/repository/ticker_repositroy.dart';
import 'package:equatable/equatable.dart';

part 'orderbook_event.dart';
part 'orderbook_state.dart';

class OrderbookBloc extends Bloc<OrderbookEvent, OrderbookState> {
  OrderbookBloc(this._tickerRepository) : super(OrderbookInitial()) {
    on<LoadOrderBookRequested>(_onLoadOrderBookRequested);
    on<ResetOrderBookStateRequested>((event, emit) => emit(OrderbookInitial()));
  }
  final TickerRepository _tickerRepository;

  void _onLoadOrderBookRequested(
      LoadOrderBookRequested event, Emitter<OrderbookState> emit) async {
    emit(OrderBookLoading());
    try {
      final OrderBook? _orderBook =
          await _tickerRepository.fetchOrderBook(event.tickerId);
      if (_orderBook != null) {
        emit(FetchOrderBookSuccessfull(_orderBook));
      } else {
        emit(FetchOrderBookFailed());
      }
    } on OrderBookFetchException catch (_) {
      emit(FetchOrderBookFailed());
    }
  }
}
