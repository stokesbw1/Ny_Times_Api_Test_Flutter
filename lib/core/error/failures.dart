import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure(this.properties);

  @override
  List<Object?> get props => [properties];
}

// General Failures
class ServerFailure extends Failure {
  const ServerFailure({List properties = const <dynamic>[]}) : super(properties);
}

class CacheFailure extends Failure {
  const CacheFailure({List properties = const <dynamic>[]}) : super(properties);
}
