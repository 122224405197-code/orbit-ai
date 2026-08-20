import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;

    return BottomNavigationBar(
      currentIndex: _getIndex(currentRoute),
      onTap: (index) {
        final routes = [
          '/dashboard',
          '/tasks',
          '/calendar',
          '/goals',
          '/habits',
        ];
        context.go(routes[index]);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          label: 'Goals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Habits',
        ),
      ],
    );
  }

  int _getIndex(String route) {
    const routes = [
      '/dashboard',
      '/tasks',
      '/calendar',
      '/goals',
      '/habits',
    ];
    return routes.indexWhere((r) => route.startsWith(r));
  }
}