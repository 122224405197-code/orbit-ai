import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../models/goal.dart';
import '../models/habit.dart';

class AppStateProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Goal> _goals = [];
  List<Habit> _habits = [];
  int _productivityScore = 87;
  int _focusTimeMinutes = 272; // 4h 32m
  int _tasksCompleted = 12;
  int _streak = 23;

  // Getters
  List<Task> get tasks => _tasks;
  List<Goal> get goals => _goals;
  List<Habit> get habits => _habits;
  int get productivityScore => _productivityScore;
  int get focusTimeMinutes => _focusTimeMinutes;
  int get tasksCompleted => _tasksCompleted;
  int get streak => _streak;

  AppStateProvider() {
    _initializeDemoData();
  }

  void _initializeDemoData() {
    _tasks = [
      Task(
        id: '1',
        title: 'Team Standup',
        time: '09:00',
        category: 'Work',
        isCompleted: false,
      ),
      Task(
        id: '2',
        title: 'Project Alpha Review',
        time: '10:30',
        category: 'Work',
        isCompleted: false,
      ),
      Task(
        id: '3',
        title: 'Lunch Break',
        time: '12:00',
        category: 'Personal',
        isCompleted: false,
      ),
      Task(
        id: '4',
        title: 'Deep Work Session',
        time: '13:00',
        category: 'Work',
        isCompleted: false,
      ),
      Task(
        id: '5',
        title: 'Client Call',
        time: '15:30',
        category: 'Work',
        isCompleted: false,
      ),
      Task(
        id: '6',
        title: 'Workout',
        time: '17:00',
        category: 'Health',
        isCompleted: false,
      ),
    ];

    _goals = [
      Goal(
        id: '1',
        title: 'Launch Orbit AI',
        progress: 75,
        category: 'Work',
      ),
      Goal(
        id: '2',
        title: 'Read 24 Books',
        progress: 45,
        category: 'Learning',
      ),
      Goal(
        id: '3',
        title: 'Fitness Goal',
        progress: 60,
        category: 'Health',
      ),
      Goal(
        id: '4',
        title: 'Meditation Streak',
        progress: 80,
        category: 'Health',
      ),
    ];

    _habits = [
      Habit(
        id: '1',
        title: 'Meditation',
        duration: '5 min daily',
        isCompleted: true,
      ),
      Habit(
        id: '2',
        title: 'Workout',
        duration: '1 hour',
        isCompleted: true,
      ),
      Habit(
        id: '3',
        title: 'No Sugar',
        duration: '24 hours',
        isCompleted: false,
      ),
    ];
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }

  void addGoal(Goal goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void updateProductivityScore(int score) {
    _productivityScore = score;
    notifyListeners();
  }
}