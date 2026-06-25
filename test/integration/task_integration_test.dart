import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/Lab-11/main.dart';

void main() {
  testWidgets('Full flow Integration Test', (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(const TasklyApp());

    // 1. Add "Original title"
    await tester.enterText(find.byKey(const Key('taskInputField')), 'Original title');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();
    expect(find.text('Original title'), findsOneWidget);

    // 2. Tap task -> open detail
    await tester.tap(find.text('Original title'));
    await tester.pumpAndSettle();
    expect(find.text('Task Detail'), findsOneWidget);

    // 3. Edit -> "Updated title"
    await tester.enterText(find.byKey(const Key('detailTitleField')), 'Updated title');

    // 4. Save
    await tester.tap(find.byKey(const Key('saveTaskButton')));
    await tester.pumpAndSettle();

    // 5. Verify updated title appears in list
    expect(find.text('Task Detail'), findsNothing); // Back to list screen
    expect(find.text('Updated title'), findsOneWidget);
    expect(find.text('Original title'), findsNothing);
  });
}
