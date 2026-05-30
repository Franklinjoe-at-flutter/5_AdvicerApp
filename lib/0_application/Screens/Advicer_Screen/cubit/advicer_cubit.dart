// ignore_for_file: type_literal_in_constant_pattern

import 'package:advicer_app/1_domain/failures/failures.dart';
import 'package:advicer_app/1_domain/usecases/advice_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advicer_state.dart';

const generalFailureMessage = "Oops! Something went wrong, Pls Try Again!";
const serverFailureMessage = "Oops! API error, Pls Try Again!";
const cacheFailureMessage = "Oops! Cache failed, Pls Try Again!";

class AdvicerCubit extends Cubit<AdvicerCubitState> {
  AdviceUseCases adviceUseCases;
  AdvicerCubit({required this.adviceUseCases}) : super(AdvicerInitialState());

  void adviceRequested() async {
    emit(AdvicerLoadingState());
    final failureOrAdvice = await adviceUseCases.getAdvice();

    failureOrAdvice.fold(
      (failure) =>
          emit(AdvicerErrorState(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdvicerLoadedState(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
