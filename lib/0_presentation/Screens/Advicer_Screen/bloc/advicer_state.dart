part of 'advicer_bloc.dart';

@immutable
sealed class AdvicerState extends Equatable {
  const AdvicerState();

  @override
  List<Object> get props => [];
}

final class AdvicerInitialState extends AdvicerState {
  const AdvicerInitialState();
}

final class AdvicerLoadingState extends AdvicerState {
  const AdvicerLoadingState();
}

final class AdvicerLoadedState extends AdvicerState {
  final String advice;
  const AdvicerLoadedState({required this.advice});

  @override
  List<Object> get props => [advice];
}

final class AdvicerErrorState extends AdvicerState {
  final String message;
  const AdvicerErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
