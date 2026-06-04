import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_widgets/get_advice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnGetAdviceButttonTap {
  void callback();
}

class MockOnGetAdviceButttonTap extends Mock implements OnGetAdviceButttonTap {}

void main() {
  Widget widgetUnderMethod({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(body: GetAdviceButton(onTap: callback)),
    );
  }

  group('Get Advice Button', () {
    group('is button rendered correctly', () {
      testWidgets('and has all parts that he needs', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderMethod());

        final buttonLabelFinder = find.text("Get Advice!");
        expect(buttonLabelFinder, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      testWidgets('when someone has pressed the button', (widgetTester) async {
        final mockOnGetAdviceButttonTap = MockOnGetAdviceButttonTap();
        await widgetTester.pumpWidget(
          widgetUnderMethod(callback: mockOnGetAdviceButttonTap.callback),
        );

        final getAdviceButtonFinder = find.byType(GetAdviceButton);

       await widgetTester.tap(getAdviceButtonFinder);
        verify(mockOnGetAdviceButttonTap.callback(),).called(1);

      });
    });
  });
}
