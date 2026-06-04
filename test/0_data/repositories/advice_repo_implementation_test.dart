import 'dart:io';

import 'package:advicer_app/1_domain/entities/advice_entity.dart';
import 'package:advicer_app/1_domain/failures/failures.dart';
import 'package:advicer_app/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/0_data/exceptions/exceptions.dart';
import 'package:advicer_app/0_data/models/advice_model.dart';
import 'package:advicer_app/0_data/repositories/advice_repo_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repo_implementation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDatasourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntity', () {
      test('when AdviceRemoteDatasource returns AdviceModel', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplementationUnderTest = AdviceRepoImplementation(
          adviceRemoteDatasource: mockAdviceRemoteDatasource,
        );

        when(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.value(AdviceModel(advice: "test", id: 42)),
        );

        final result = await adviceRepoImplementationUnderTest
            .getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          Right<Failure, AdviceModel>(AdviceModel(advice: "test", id: 42)),
        );
        verify(mockAdviceRemoteDatasource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDatasource);
      });
    });

    group('should return left with', () {
      test('a server exception when a server failure occurs', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplementationUnderTest = AdviceRepoImplementation(
          adviceRemoteDatasource: mockAdviceRemoteDatasource,
        );

        when(
          mockAdviceRemoteDatasource.getRandomAdviceFromApi(),
        ).thenThrow(ServerException());

        final result = await adviceRepoImplementationUnderTest
            .getAdviceFromDatasource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test('a general failure on all other exceptions', () async {
        final mockAdviceRemoteDatasource = MockAdviceRemoteDatasourceImpl();
        final adviceRepoImplementationUnderTest = AdviceRepoImplementation(
          adviceRemoteDatasource: mockAdviceRemoteDatasource,
        );

        when(
          mockAdviceRemoteDatasource.getRandomAdviceFromApi(),
        ).thenThrow(const SocketException('test'));

        final result = await adviceRepoImplementationUnderTest
            .getAdviceFromDatasource();
        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
