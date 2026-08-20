import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/goal_card.dart';
import '../widgets/bottom_nav.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, appState, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appState.goals.length,
            itemBuilder: (context, index) {
              return GoalCard(goal: appState.goals[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}