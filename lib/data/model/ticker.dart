import 'package:equatable/equatable.dart';

class Ticker extends Equatable {
  const Ticker({
    required this.timeStamp,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.lastPrice,
    required this.volume,
  });

  static Ticker fromJson(Map<String, dynamic> json) {
    return Ticker(
      timeStamp: json['timestamp'] as DateTime,
      openPrice: json['open'] as String,
      highPrice: json['high'],
      lowPrice: json['low'],
      lastPrice: json['last'],
      volume: json['volume'],
    );
  }

  final DateTime timeStamp;
  final String openPrice;
  final String highPrice;
  final String lowPrice;
  final String lastPrice;
  final String volume;

  @override
  List<Object?> get props =>
      [timeStamp, openPrice, highPrice, lowPrice, lastPrice, volume];
}
