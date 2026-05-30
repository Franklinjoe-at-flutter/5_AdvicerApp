import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {}

class ServerFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GeneralFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
