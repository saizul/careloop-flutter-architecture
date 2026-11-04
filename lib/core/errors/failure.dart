import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
    this.cause,
  });

  final String message;
  final String? code;
  final Object? cause;

  @override
  List<Object?> get props => [message, code, cause];
}
