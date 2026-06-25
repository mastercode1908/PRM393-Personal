import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/Lab-11/repositories/task_repository.dart';
import 'package:learn_flutter/Lab-11/screens/task_list_screen.dart';

void main() {
  Widget createWidgetUnderTest(TaskRepository repository) {
    return MaterialApp(
      home: TaskListScreen(repository: repository),
    );
  }

  testWidgets('Empty State displays "No tasks yet. Add one!"', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(createWidgetUnderTest(repository));

    expect(find.text('No tasks yet. Add one!'), findsOneWidget);
  });

  testWidgets('Add Task: enter text -> tap add -> verify UI updates', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(createWidgetUnderTest(repository));

    await tester.enterText(find.byKey(const Key('taskInputField')), 'Buy Groceries');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    expect(find.text('Buy Groceries'), findsOneWidget);
    expect(find.text('No tasks yet. Add one!'), findsNothing);
  });

  testWidgets('Multiple Tasks: add two tasks -> verify both visible', (WidgetTester tester) async {
    final repository = TaskRepository();
    await tester.pumpWidget(createWidgetUnderTest(repository));

    await tester.enterText(find.byKey(const Key('taskInputField')), 'Task 1');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    await tester.enterText(find.byKey(const Key('taskInputField')), 'Task 2');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  });
}
