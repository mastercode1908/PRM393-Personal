import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 30,
              height: 30,
              errorBuilder: (_, __, ___) => const Icon(Icons.check_circle),
            ),
            const SizedBox(width: 10),
            const Text('Taskly Optimized'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Enter task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final title = controller.text.trim();
                    if (title.isNotEmpty) {
                      context.read<TaskProvider>().addTask(title);
                      controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            // Use Selector to only rebuild when the task list length or references change
            child: Selector<TaskProvider, List<Task>>(
              selector: (context, provider) => provider.tasks,
              builder: (context, tasks, child) {
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks yet. Add one!'));
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    // Using ValueKey properly
                    return TaskTile(
                      key: ValueKey(task.id),
                      task: task,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
