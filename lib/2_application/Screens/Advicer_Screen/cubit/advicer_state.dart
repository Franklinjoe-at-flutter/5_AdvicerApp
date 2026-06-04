part of 'advicer_cubit.dart';

sealed class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();

  @override
  List<Object> get props => [];
}

class AdvicerInitialState extends AdvicerCubitState {
  const AdvicerInitialState();
}

class AdvicerLoadingState extends AdvicerCubitState {
  const AdvicerLoadingState();
}

class AdvicerLoadedState extends AdvicerCubitState {
  final String advice;
  const AdvicerLoadedState({required this.advice});

  @override
  List<Object> get props => [advice];
}

class AdvicerErrorState extends AdvicerCubitState {
  final String message;
  const AdvicerErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
