import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/productivity_score_card.dart';
import '../widgets/task_card.dart';
import '../widgets/goal_card.dart';
import '../widgets/bottom_nav.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AppStateProvider>(
            builder: (context, appState, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  Text(
                    'Good Morning, User! 👋',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here\'s your overview for today.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Key Metrics Row
                  Row(
                    children: [
                      Expanded(
                        child: ProductivityScoreCard(
                          score: appState.productivityScore,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MetricCard(
                          label: 'Tasks',
                          value: appState.tasksCompleted.toString(),
                          subtitle: '/15',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MetricCard(
                          label: 'Focus',
                          value: '4h',
                          subtitle: '32m',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Today's Tasks
                  Text(
                    'Today\'s Tasks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...appState.tasks.take(3).map((task) => TaskCard(task: task)),

                  const SizedBox(height: 24),

                  // Goals Progress
                  Text(
                    'Goals Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...appState.goals.map((goal) => GoalCard(goal: goal)),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;

  const MetricCard({
    Key? key,
    required this.label,
    required this.value,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}