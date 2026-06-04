import 'package:advicer_app/1_domain/entities/advice_entity.dart';
import 'package:advicer_app/1_domain/failures/failures.dart';
import 'package:advicer_app/1_domain/usecases/advice_usecases.dart';
import 'package:advicer_app/0_data/repositories/advice_repo_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usescases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImplementation>()])
void main() {
  group('AdviceUsecases', () {
    group('should return AdviceEntity', () {
      test('when adviceRepoImpl returns an AdviceModel', () async {
        final mockadviceRepoImpl = MockAdviceRepoImplementation();
        final adviceUseCasesUnderTest = AdviceUseCases(
          adviceRepo: mockadviceRepoImpl,
        );

        when(mockadviceRepoImpl.getAdviceFromDatasource()).thenAnswer(
          (realInvocation) =>
              Future.value(Right(AdviceEntity(advice: "test", id: 42))),
        );

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          Right<Failure, AdviceEntity>(AdviceEntity(advice: "test", id: 42)),
        );
        verify(mockadviceRepoImpl.getAdviceFromDatasource()).called(1);

        /* ! verify was not called: verifyNever(
          mockadviceRepoImpl.adviceRemoteDatasource);, intead of .called(0) */
        verifyNoMoreInteractions(mockadviceRepoImpl);
      });
    });

    group('should return left with', () {
      test('a Server Failure', () async {
        final mockadviceRepoImpl = MockAdviceRepoImplementation();
        final adviceUseCasesUnderTest = AdviceUseCases(
          adviceRepo: mockadviceRepoImpl,
        );

        when(
          mockadviceRepoImpl.getAdviceFromDatasource(),
        ).thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockadviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockadviceRepoImpl);
      });

      test('a General Failure', () async {
        final mockadviceRepoImpl = MockAdviceRepoImplementation();
        final adviceUseCasesUnderTest = AdviceUseCases(
          adviceRepo: mockadviceRepoImpl,
        );

        when(
          mockadviceRepoImpl.getAdviceFromDatasource(),
        ).thenAnswer((realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockadviceRepoImpl.getAdviceFromDatasource()).called(1);
        verifyNoMoreInteractions(mockadviceRepoImpl);
      });
    });
  });
}
