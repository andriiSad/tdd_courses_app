import 'package:equatable/equatable.dart';
import 'package:tdd_courses_app/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  factory ServerFailure.fromException(ServerException exception) =>
      ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}
