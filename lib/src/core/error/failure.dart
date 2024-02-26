import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final String? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message];
}
