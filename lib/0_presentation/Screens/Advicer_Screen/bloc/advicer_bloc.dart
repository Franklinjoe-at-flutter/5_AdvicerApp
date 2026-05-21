import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  AdvicerBloc() : super(AdvicerInitialState()) {
    on<AdviceRequestedEvent>((event, emit) async {
      emit(AdvicerLoadingState());

      await Future.delayed(Duration(seconds: 3));

      //emit(AdvicerLoadedState(advice: "advice loaded!"));

      emit(AdvicerErrorState(message: "Oops!"));
    });
  }
}
