part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object> get props => [];
}

//MIXINS

class TickerDataMixin {
  late final Ticker ticker;
}

class TickerIDMixin {
  late final String tickerId;
}

class CryptoInitial extends CryptoState {}

class TickerDateLoading extends CryptoState with TickerIDMixin {
  TickerDateLoading(String tickerId) {
    this.tickerId = tickerId;
  }
}

class UnsupportedTicker extends CryptoState with TickerIDMixin {
  UnsupportedTicker(String tickerId) {
    this.tickerId = tickerId;
  }
}

class FetchingTickerDataFailed extends CryptoState with TickerIDMixin {
  FetchingTickerDataFailed(String tickerId) {
    this.tickerId = tickerId;
  }
}

class FetchingTickerDataSuccessfull extends CryptoState
    with TickerDataMixin, TickerIDMixin {
  FetchingTickerDataSuccessfull(String tickerId, Ticker ticker) {
    this.tickerId = tickerId;
    this.ticker = ticker;
  }
}
