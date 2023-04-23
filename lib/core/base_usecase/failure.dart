import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    final msg = "${runtimeType.toString()}: ${message ?? ''}";
    return msg;
  }
}

class ApiFailure implements Failure {
  @override
  final String message;

  ApiFailure(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool get stringify => true;

  @override
  String toString() {
    final msg = "${runtimeType.toString()}: $message";
    return msg;
  }
}

class InternetFailure extends Failure {}
