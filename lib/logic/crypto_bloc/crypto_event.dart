part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object> get props => [];
}

class CryptoTickerSearched extends CryptoEvent {
  const CryptoTickerSearched(this.tickerID);
  final String tickerID;
}
