import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/bottom_nav.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, appState, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.habits.length,
            itemBuilder: (context, index) {
              final habit = appState.habits[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: habit.isCompleted,
                        onChanged: (value) {},
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.title,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              habit.duration,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}