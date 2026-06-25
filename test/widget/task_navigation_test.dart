import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/Lab-11/models/task.dart';
import 'package:learn_flutter/Lab-11/repositories/task_repository.dart';
import 'package:learn_flutter/Lab-11/screens/task_list_screen.dart';

void main() {
  testWidgets('Navigation Testing: Task List -> Task Detail', (WidgetTester tester) async {
    // 1. Seed repository with at least one task
    final repository = TaskRepository();
    repository.addTask(Task(id: 'seeded_1', title: 'Seeded Task'));

    // 2. Pump TaskListScreen
    await tester.pumpWidget(MaterialApp(
      home: TaskListScreen(repository: repository),
    ));

    // 3. Tap seeded task -> call pumpAndSettle()
    await tester.tap(find.text('Seeded Task'));
    await tester.pumpAndSettle();

    // 4. Validate AppBar title and TextField key
    expect(find.text('Task Detail'), findsOneWidget);
    expect(find.byKey(const Key('detailTitleField')), findsOneWidget);
  });
}
