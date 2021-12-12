import 'package:crypto_pair_app/data/model/order_book.dart';
import 'package:crypto_pair_app/data/model/ticker.dart';
import 'package:crypto_pair_app/services/dio_client.dart';
import 'package:dio/dio.dart';

class TickerDataFetchException implements Exception {
  TickerDataFetchException(this.message);
  final String message;
}

class OrderBookFetchException implements Exception {
  OrderBookFetchException(this.message);
  final String message;
}

class TickerRepository {
  final Client _client = Client();

  Future<Ticker?> fetchTickerData(String tickerID) async {
    try {
      final Response response = await _client.getDio().get('ticker/$tickerID');
      if (response.statusCode == 200) {
        if (response.data != null) {
          return Ticker.fromJson(response.data as Map<String, dynamic>);
        }
      } else {
        return null;
      }
    } catch (e) {
      throw TickerDataFetchException(e.toString());
    }
  }

  Future<OrderBook?> fetchOrderBook(String tickerId) async {
    try {
      final Response response =
          await _client.getDio().get('order_book/$tickerId');
      if (response.statusCode == 200) {
        if (response.data != null) {
          return OrderBook.fromJson(response.data as Map<String, dynamic>);
        }
      } else {
        return null;
      }
    } catch (e) {
      throw TickerDataFetchException(e.toString());
    }
  }
}
