import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../models/goal.dart';
import '../models/habit.dart';
import '../models/user_profile.dart';
import '../models/adaptive_metric.dart';
import '../models/ai_recommendation.dart';
import '../models/user_insight.dart';
import '../models/life_balance.dart';

class AppStateProvider extends ChangeNotifier {
  UserProfile? _userProfile;
  List<Task> _tasks = [];
  List<Goal> _goals = [];
  List<Habit> _habits = [];
  List<AdaptiveMetric> _metrics = [];
  List<AIRecommendation> _recommendations = [];
  List<UserInsight> _insights = [];
  LifeBalance? _lifeBalance;
  
  int _productivityScore = 87;
  int _focusTimeMinutes = 272;
  int _tasksCompleted = 12;
  int _streak = 23;

  // Getters
  UserProfile? get userProfile => _userProfile;
  List<Task> get tasks => _tasks;
  List<Goal> get goals => _goals;
  List<Habit> get habits => _habits;
  List<AdaptiveMetric> get metrics => _metrics;
  List<AIRecommendation> get recommendations => _recommendations;
  List<UserInsight> get insights => _insights;
  LifeBalance? get lifeBalance => _lifeBalance;
  int get productivityScore => _productivityScore;
  int get focusTimeMinutes => _focusTimeMinutes;
  int get tasksCompleted => _tasksCompleted;
  int get streak => _streak;

  AppStateProvider() {
    _initializeDemoData();
  }

  void setUserProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
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

    // Initialize demo metrics
    _metrics = [
      AdaptiveMetric(
        id: '1',
        userId: 'demo',
        name: 'Morning Energy',
        type: MetricType.energy,
        category: 'Health',
        value: 85,
      ),
      AdaptiveMetric(
        id: '2',
        userId: 'demo',
        name: 'Focus Level',
        type: MetricType.focus,
        category: 'Work',
        value: 75,
      ),
      AdaptiveMetric(
        id: '3',
        userId: 'demo',
        name: 'Mood',
        type: MetricType.mood,
        category: 'Wellness',
        value: 80,
      ),
      AdaptiveMetric(
        id: '4',
        userId: 'demo',
        name: 'Stress Level',
        type: MetricType.stress,
        category: 'Wellness',
        value: 30,
      ),
    ];

    // Initialize demo recommendations
    _recommendations = [
      AIRecommendation(
        id: '1',
        userId: 'demo',
        type: RecommendationType.focus,
        title: 'Peak Focus Time',
        description: 'Your focus levels are highest between 9 AM - 12 PM',
        reason: 'Based on your daily patterns',
        priority: 8,
      ),
      AIRecommendation(
        id: '2',
        userId: 'demo',
        type: RecommendationType.wellness,
        title: 'Take a Break',
        description: 'You\'ve been working for 2.5 hours. A 15-min break improves focus.',
        reason: 'Research shows regular breaks boost productivity',
        priority: 7,
      ),
      AIRecommendation(
        id: '3',
        userId: 'demo',
        type: RecommendationType.sleep,
        title: 'Sleep Priority',
        description: 'Earlier sleep schedule correlates with higher daily energy',
        reason: 'Your energy metrics show evening fatigue',
        priority: 9,
      ),
    ];

    // Initialize demo insights
    _insights = [
      UserInsight(
        id: '1',
        userId: 'demo',
        title: 'Energy Peak Found',
        description: 'Your energy levels are highest in the morning (9-11 AM)',
        category: 'productivity',
        data: {'avgMorningEnergy': '85', 'avgAfternoonEnergy': '65'},
        actionableSteps: [
          'Schedule important tasks for morning',
          'Use afternoons for routine work',
          'Consider a power nap at 3 PM',
        ],
      ),
      UserInsight(
        id: '2',
        userId: 'demo',
        title: 'Stress-Sleep Connection',
        description: 'Your stress levels drop when you sleep 7+ hours',
        category: 'wellness',
        data: {'sleepCorrelation': '0.82'},
        actionableSteps: [
          'Maintain consistent sleep schedule',
          'Aim for 7-8 hours nightly',
          'Track sleep to optimize',
        ],
      ),
      UserInsight(
        id: '3',
        userId: 'demo',
        title: 'Habit Impact',
        description: 'Your daily meditation correlates with 20% higher focus',
        category: 'habits',
        data: {'focusIncrease': '20%'},
        actionableSteps: [
          'Keep meditation consistent',
          'Increase to 10 minutes gradually',
          'Track meditation impact',
        ],
      ),
    ];

    // Initialize demo life balance
    _lifeBalance = LifeBalance(
      userId: 'demo',
      date: DateTime.now(),
      categoryBalance: {
        'Work': 70,
        'Health': 75,
        'Learning': 65,
        'Relationships': 60,
        'Wellness': 80,
        'Creativity': 55,
      },
      overallBalance: 68,
      insight: 'Good balance overall, but relationships need more attention.',
      recommendations: [
        'Increase quality time with family',
        'Schedule weekly social activities',
        'Maintain health momentum',
      ],
    );
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

  void updateGoalProgress(String id, int newProgress) {
    final index = _goals.indexWhere((g) => g.id == id);
    if (index != -1) {
      _goals[index] = Goal(
        id: _goals[index].id,
        title: _goals[index].title,
        progress: newProgress,
        category: _goals[index].category,
      );
      notifyListeners();
    }
  }

  void addMetric(AdaptiveMetric metric) {
    _metrics.add(metric);
    notifyListeners();
  }

  void updateProductivityScore(int score) {
    _productivityScore = score;
    notifyListeners();
  }

  void updateLifeBalance(LifeBalance balance) {
    _lifeBalance = balance;
    notifyListeners();
  }

  void clearAllData() {
    _userProfile = null;
    _tasks = [];
    _goals = [];
    _habits = [];
    _metrics = [];
    _recommendations = [];
    _insights = [];
    _lifeBalance = null;
    notifyListeners();
  }
}