import 'package:advicer_app/2_application/Screens/Advicer_Screen/advicer_widgets/loaded_advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget widgetsUnderTest({required String adviceText}) {
  return MaterialApp(home: LoadedAdviceField(advice: adviceText));
}

void main() {
  group('Advice Field', () {
    group('shoud display correctly ', () {
      testWidgets("when a short text is given", (widgetTester) async {
        final text = 'a';

        await widgetTester.pumpWidget(widgetsUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text("a");
        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets("when a long text is given", (widgetTester) async {
        final text =
            'Hello flutter developers, i hope you enjoy the course and have a great time. the sun is shining, i have no idea what else i should write here to get a very long text';

        await widgetTester.pumpWidget(widgetsUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(LoadedAdviceField);
        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets("when no text is given", (widgetTester) async {
        final text = '';

        await widgetTester.pumpWidget(widgetsUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text(LoadedAdviceField.emptyAdvice);
        final adviceText = widgetTester
            .widget<LoadedAdviceField>(find.byType(LoadedAdviceField))
            .advice;
        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, "");
        
      });
    });
  });
}
