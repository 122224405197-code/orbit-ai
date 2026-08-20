import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/task_card.dart';
import '../widgets/bottom_nav.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, appState, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.tasks.length,
            itemBuilder: (context, index) {
              return TaskCard(task: appState.tasks[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}