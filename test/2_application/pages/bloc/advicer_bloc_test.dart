import 'package:advicer_app/0_application/Screens/Advicer_Screen/bloc/advicer_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdvicerBloc', () {
    group('should emit', () {
      blocTest<AdvicerBloc, AdvicerState>(
        "nothing when no event is added",
        build: () => AdvicerBloc(),
        expect: () => const <AdvicerState>[],
      );

      blocTest(
        "[AdvcierStateLoading, ErrorState] when adviceRequestedEvent is Added",
        build: () => AdvicerBloc(),
        act: (bloc) => bloc.add(AdviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdvicerState>[
          AdvicerLoadingState(),
          AdvicerErrorState(message: "Oops!"),
        ],
      );
    });
  });
}
