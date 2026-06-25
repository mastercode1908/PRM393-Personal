import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/Lab-11/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('Default completed value should be false', () {
      // Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Act & Assert
      expect(task.isCompleted, isFalse);
    });

    test('toggle() switches isCompleted true <-> false', () {
      // Arrange
      final task = Task(id: '1', title: 'Test Task');

      // Act
      task.toggle();

      // Assert
      expect(task.isCompleted, isTrue);

      // Act again
      task.toggle();

      // Assert again
      expect(task.isCompleted, isFalse);
    });
  });
}
