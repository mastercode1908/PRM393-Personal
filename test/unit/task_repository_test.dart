import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/Lab-11/models/task.dart';
import 'package:learn_flutter/Lab-11/repositories/task_repository.dart';

void main() {
  late TaskRepository repository;

  setUp(() {
    repository = TaskRepository();
  });

  group('TaskRepository Tests', () {
    test('addTask() adds a task to the list', () {
      // Arrange
      final task = Task(id: '1', title: 'New Task');

      // Act
      repository.addTask(task);

      // Assert
      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'New Task');
    });

    test('updateTask() changes the title of an existing task', () {
      // Arrange
      final task = Task(id: '1', title: 'Old Title');
      repository.addTask(task);

      // Act
      repository.updateTask('1', 'New Title');

      // Assert
      expect(repository.tasks.first.title, 'New Title');
    });

    test('deleteTask() removes a task from the list', () {
      // Arrange
      final task = Task(id: '1', title: 'Task to Delete');
      repository.addTask(task);
      expect(repository.tasks.length, 1);

      // Act
      repository.deleteTask('1');

      // Assert
      expect(repository.tasks.isEmpty, isTrue);
    });
  });
}
