import 'package:advicer_app/0_application/Screens/Advicer_Screen/cubit/advicer_cubit.dart';
import 'package:advicer_app/1_domain/entities/advice_entity.dart';
import 'package:advicer_app/1_domain/failures/failures.dart';
import 'package:advicer_app/1_domain/usecases/advice_usecases.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCases extends Mock implements AdviceUseCases {}

void main() {
  group('AdviceCubit', () {
    group('should emit', () {
      MockAdviceUseCases mockAdviceUseCases = MockAdviceUseCases();
      blocTest(
        "nothing when no request event is added",
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        expect: () => <AdvicerCubitState>[],
      );

      blocTest(
        "[AdvicerLoadingState, AdvicerLoadedState] when adviceRequested is called",
        build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
        setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: "advice", id: 1),
            ),
          ),
        ),
        act: (cubit) => cubit.adviceRequested(),
        wait: Duration(seconds: 3),
        expect: () => <AdvicerCubitState>[
          AdvicerLoadingState(),
          AdvicerLoadedState(advice: "advice"),
        ],
      );

      group(
        '[AdvicerStateLoading, ErrorState] when adviceRequested is called',
        () {
          blocTest(
            "and a server failure occurs",
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
            setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntity>(ServerFailure())),
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => const <AdvicerCubitState>[
              AdvicerLoadingState(),
              AdvicerErrorState(message: serverFailureMessage),
            ],
          );

          blocTest(
            "and a Cache failure occurs",
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
            setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntity>(CacheFailure())),
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => const <AdvicerCubitState>[
              AdvicerLoadingState(),
              AdvicerErrorState(message: cacheFailureMessage),
            ],
          );

          blocTest(
            "and a general failure occurs",
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCases),
            setUp: () => when(() => mockAdviceUseCases.getAdvice()).thenAnswer(
              (invocation) =>
                  Future.value(Left<Failure, AdviceEntity>(GeneralFailure())),
            ),
            act: (cubit) => cubit.adviceRequested(),
            expect: () => const <AdvicerCubitState>[
              AdvicerLoadingState(),
              AdvicerErrorState(message: generalFailureMessage),
            ],
          );
        },
      );
    });
  });
}
