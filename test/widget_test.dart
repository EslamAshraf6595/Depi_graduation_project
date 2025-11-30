import 'package:flutter_test/flutter_test.dart';

import 'package:fitness_app_amr/main.dart';

void main() {
  testWidgets('GoalsScreen shows correct UI elements',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FitnessApp());

    // Verify the title "Goals" is displayed
    expect(find.text("Goals"), findsOneWidget);

    // Verify progress text is there
    expect(find.textContaining("Overall progress"), findsOneWidget);

    // Verify "Plans" tab is visible
    expect(find.text("Plans"), findsOneWidget);

    // Verify "Exercises" tab is visible
    expect(find.text("Exercises"), findsOneWidget);

    // Verify the "Create new plan" button is visible
    expect(find.text("+ Create new plan"), findsOneWidget);

    // Verify at least one "Push ups" card exists
    expect(find.text("Push ups"), findsWidgets);
  });
}
