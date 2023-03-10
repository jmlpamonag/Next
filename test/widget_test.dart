import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next/src/app.dart';

void main() {
  testWidgets('Testing Home Screen...', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    expect(find.text('Next'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Testing Record Screen...', (WidgetTester tester) async {
      // Navigate to Record Screen
      await tester.pumpWidget(App());
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle(Duration(milliseconds:400));

      // Verify that we have the form by checking number of form fields
      expect(find.byType(TextFormField), findsNWidgets(1));
      expect(find.byType(TextField), findsAtLeastNWidgets(4));
  });
}
