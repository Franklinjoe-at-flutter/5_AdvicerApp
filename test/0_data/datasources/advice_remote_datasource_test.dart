import 'package:advicer_app/2_data/datasources/advice_remote_datasource.dart';
import 'package:advicer_app/2_data/exceptions/exceptions.dart';
import 'package:advicer_app/2_data/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDataSource', () {
    group('should return advice model', () {
      test('when client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest = AdviceRemoteDatasourceImpl(
          client: mockClient,
        );
        final responseBody = '{"advice" : "test advice", "advice_id" : 1}';

        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.de/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)),
        );
        final result = await adviceRemoteDatasourceUnderTest
            .getRandomAdviceFromApi();
        expect(result, AdviceModel(advice: "test advice", id: 1));
      });
    });

    group('should throw', () {
      test('throw a server exception when status code is not 200', () {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest = AdviceRemoteDatasourceImpl(
          client: mockClient,
        );
        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.de/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          ),
        ).thenAnswer((realInvocation) => Future.value(Response("", 201)));

        expect(
          () => adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
          throwsA(isA<ServerException>()),
        );
      });

      test('A type error when status was 200 but no valid data', () {
        final mockClient = MockClient();
        final adviceRemoteDatasourceUnderTest = AdviceRemoteDatasourceImpl(
          client: mockClient,
        );
        final responseBody = '{"advice" : "test advice"}';
        when(
          mockClient.get(
            Uri.parse('https://api.flutter-community.de/api/v1/advice'),
            headers: {'content-type': 'application/json'},
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(Response(responseBody, 200)),
        );

        expect(
          () => adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi(),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });
}
