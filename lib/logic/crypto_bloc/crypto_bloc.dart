import 'package:bloc/bloc.dart';
import 'package:crypto_pair_app/data/model/ticker.dart';
import 'package:crypto_pair_app/data/repository/ticker_repositroy.dart';
import 'package:crypto_pair_app/utils/constants.dart';
import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc(this._tickerRepository) : super(CryptoInitial()) {
    on<CryptoTickerSearched>(_onCryptoTickerSearched);
  }
  final TickerRepository _tickerRepository;

  void _onCryptoTickerSearched(
      CryptoTickerSearched event, Emitter<CryptoState> emit) async {
    emit(TickerDateLoading(event.tickerID));
    final List<String> supportedTickerList = supportedCryptos.split(', ');
    try {
      if (supportedTickerList.contains(event.tickerID)) {
        final Ticker? _ticker =
            await _tickerRepository.fetchTickerData(event.tickerID);
        if (_ticker != null) {
          emit(FetchingTickerDataSuccessfull(event.tickerID, _ticker));
        } else {
          emit(FetchingTickerDataFailed(event.tickerID));
        }
      } else {
        emit(UnsupportedTicker(event.tickerID));
      }
    } on TickerDataFetchException catch (_) {
      emit(FetchingTickerDataFailed(event.tickerID));
    }
  }
}
