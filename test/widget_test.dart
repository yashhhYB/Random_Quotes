import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Fetch quote test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyAnimatedBackground());


    // Verify that the initial quote is displayed.
    expect(find.text('Press the button to fetch a quote!'), findsOneWidget);
    await tester.tap(find.text('Fetch Quote'));
    await tester.pump();
    expect(find.text('Press the button to fetch a quote!'), findsNothing);

  });
}
