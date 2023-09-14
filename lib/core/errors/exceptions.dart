import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  }) : super();
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({
    required this.message,
    this.statusCode = 500,
  }) : super();
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
