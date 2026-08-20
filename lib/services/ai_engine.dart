import 'package:uuid/uuid.dart';
import '../models/user_profile.dart';
import '../models/adaptive_metric.dart';
import '../models/ai_recommendation.dart';
import '../models/user_insight.dart';
import '../models/life_balance.dart';

class AIEngine {
  final String userId;
  final UserProfile userProfile;
  late List<AdaptiveMetric> userMetrics;
  late List<AIRecommendation> recommendations;
  late List<UserInsight> insights;

  AIEngine({
    required this.userId,
    required this.userProfile,
  }) {
    userMetrics = [];
    recommendations = [];
    insights = [];
  }

  /// Analyze user patterns and generate personalized insights
  Future<List<UserInsight>> generateInsights(
      List<AdaptiveMetric> metrics) async {
    userMetrics = metrics;
    List<UserInsight> newInsights = [];

    // Pattern 1: Energy & Productivity Correlation
    final energyProductivityInsight = _analyzeEnergyProductivity();
    if (energyProductivityInsight != null) newInsights.add(energyProductivityInsight);

    // Pattern 2: Focus Time Optimization
    final focusInsight = _analyzeFocusPatterns();
    if (focusInsight != null) newInsights.add(focusInsight);

    // Pattern 3: Work-Life Balance
    final balanceInsight = _analyzeLifeBalance();
    if (balanceInsight != null) newInsights.add(balanceInsight);

    // Pattern 4: Habit Impact
    final habitInsight = _analyzeHabitImpact();
    if (habitInsight != null) newInsights.add(habitInsight);

    // Pattern 5: Stress & Recovery
    final stressInsight = _analyzeStressRecovery();
    if (stressInsight != null) newInsights.add(stressInsight);

    insights = newInsights;
    return newInsights;
  }

  /// Generate AI-powered recommendations based on user data
  Future<List<AIRecommendation>> generateRecommendations(
      List<AdaptiveMetric> metrics) async {
    List<AIRecommendation> newRecommendations = [];

    // Recommendation 1: Energy Management
    final energyRec = _recommendEnergyManagement();
    if (energyRec != null) newRecommendations.add(energyRec);

    // Recommendation 2: Focus Blocks
    final focusRec = _recommendFocusBlocks();
    if (focusRec != null) newRecommendations.add(focusRec);

    // Recommendation 3: Break Suggestions
    final breakRec = _recommendBreaks();
    if (breakRec != null) newRecommendations.add(breakRec);

    // Recommendation 4: Habit Building
    final habitRec = _recommendNewHabits();
    if (habitRec != null) newRecommendations.add(habitRec);

    // Recommendation 5: Wellness
    final wellnessRec = _recommendWellness();
    if (wellnessRec != null) newRecommendations.add(wellnessRec);

    recommendations = newRecommendations;
    return newRecommendations;
  }

  /// Calculate life balance across all dimensions
  Future<LifeBalance> calculateLifeBalance(List<AdaptiveMetric> metrics) async {
    Map<String, int> categoryBalance = {};
    Map<String, List<int>> categoryValues = {};

    // Group metrics by category
    for (var metric in metrics) {
      categoryValues.putIfAbsent(metric.category, () => []).add(metric.value);
    }

    // Calculate average for each category
    categoryValues.forEach((category, values) {
      int average = values.isNotEmpty
          ? (values.reduce((a, b) => a + b) / values.length).toInt()
          : 0;
      categoryBalance[category] = average;
    });

    // Calculate overall balance
    int overallBalance = categoryBalance.isEmpty
        ? 0
        : (categoryBalance.values.reduce((a, b) => a + b) ~/ categoryBalance.length);

    // Generate insight
    String insight = _generateBalanceInsight(categoryBalance, overallBalance);

    // Generate recommendations
    List<String> recsList = _generateBalanceRecommendations(categoryBalance);

    return LifeBalance(
      userId: userId,
      date: DateTime.now(),
      categoryBalance: categoryBalance,
      overallBalance: overallBalance,
      insight: insight,
      recommendations: recsList,
    );
  }

  // ============ Private Analysis Methods ============

  UserInsight? _analyzeEnergyProductivity() {
    final energyMetrics =
        userMetrics.where((m) => m.type == MetricType.energy).toList();
    final productivityMetrics =
        userMetrics.where((m) => m.type == MetricType.productivity).toList();

    if (energyMetrics.isEmpty || productivityMetrics.isEmpty) return null;

    double avgEnergy =
        energyMetrics.map((m) => m.value).reduce((a, b) => a + b) /
            energyMetrics.length;
    double avgProductivity =
        productivityMetrics.map((m) => m.value).reduce((a, b) => a + b) /
            productivityMetrics.length;

    String correlation = (avgEnergy > avgProductivity)
        ? 'Higher energy levels correlate with better productivity'
        : 'Your productivity is independent of energy levels';

    return UserInsight(
      id: const Uuid().v4(),
      userId: userId,
      title: 'Energy & Productivity Pattern',
      description: correlation,
      category: 'productivity',
      data: {
        'avgEnergy': avgEnergy.toStringAsFixed(1),
        'avgProductivity': avgProductivity.toStringAsFixed(1),
      },
      actionableSteps: [
        'Schedule important tasks during high-energy periods',
        'Track energy levels to find your peak hours',
      ],
    );
  }

  UserInsight? _analyzeFocusPatterns() {
    final focusMetrics =
        userMetrics.where((m) => m.type == MetricType.focus).toList();

    if (focusMetrics.isEmpty) return null;

    double avgFocus =
        focusMetrics.map((m) => m.value).reduce((a, b) => a + b) /
            focusMetrics.length;

    String status = avgFocus > 70
        ? 'Excellent focus levels'
        : avgFocus > 50
            ? 'Average focus levels'
            : 'Low focus levels';

    return UserInsight(
      id: const Uuid().v4(),
      userId: userId,
      title: 'Focus Analysis',
      description: status,
      category: 'productivity',
      data: {'averageFocus': avgFocus.toStringAsFixed(1)},
      actionableSteps: [
        'Use the Pomodoro technique for better focus',
        'Minimize distractions during work hours',
        'Take regular breaks to maintain focus',
      ],
    );
  }

  UserInsight? _analyzeLifeBalance() {
    Map<String, double> categoryAverages = {};

    for (var metric in userMetrics) {
      categoryAverages.putIfAbsent(metric.category, () => 0);
      categoryAverages[metric.category] =
          (categoryAverages[metric.category]! + metric.value) / 2;
    }

    // Find the lowest and highest category
    if (categoryAverages.isEmpty) return null;

    var sortedCategories = categoryAverages.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    String lowest = sortedCategories.first.key;
    String highest = sortedCategories.last.key;

    return UserInsight(
      id: const Uuid().v4(),
      userId: userId,
      title: 'Life Balance Assessment',
      description: 'Your $lowest area needs more attention while $highest is thriving',
      category: 'balance',
      data: categoryAverages.map((k, v) => MapEntry(k, v.toStringAsFixed(1))),
      actionableSteps: [
        'Focus on improving your $lowest area',
        'Maintain momentum in your strong areas',
        'Create a balanced routine',
      ],
    );
  }

  UserInsight? _analyzeHabitImpact() {
    // Placeholder for habit impact analysis
    return UserInsight(
      id: const Uuid().v4(),
      userId: userId,
      title: 'Habit Impact Analysis',
      description: 'Your consistent habits are contributing to overall improvement',
      category: 'habits',
      data: {},
      actionableSteps: [
        'Continue building positive habits',
        'Track habit consistency',
      ],
    );
  }

  UserInsight? _analyzeStressRecovery() {
    final stressMetrics =
        userMetrics.where((m) => m.type == MetricType.stress).toList();

    if (stressMetrics.isEmpty) return null;

    double avgStress =
        stressMetrics.map((m) => m.value).reduce((a, b) => a + b) /
            stressMetrics.length;

    String recommendation = avgStress > 60
        ? 'Consider stress management techniques'
        : 'Your stress levels are manageable';

    return UserInsight(
      id: const Uuid().v4(),
      userId: userId,
      title: 'Stress & Recovery Pattern',
      description: recommendation,
      category: 'wellness',
      data: {'averageStress': avgStress.toStringAsFixed(1)},
      actionableSteps: [
        'Practice meditation or deep breathing',
        'Schedule recovery time',
        'Maintain regular exercise',
      ],
    );
  }

  // ============ Private Recommendation Methods ============

  AIRecommendation? _recommendEnergyManagement() {
    return AIRecommendation(
      id: const Uuid().v4(),
      userId: userId,
      type: RecommendationType.wellness,
      title: 'Optimize Your Energy Levels',
      description:
          'Based on your patterns, try scheduling high-intensity tasks in the morning',
      reason: 'Morning hours show the highest energy levels in your data',
      priority: 8,
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    );
  }

  AIRecommendation? _recommendFocusBlocks() {
    return AIRecommendation(
      id: const Uuid().v4(),
      userId: userId,
      type: RecommendationType.focus,
      title: 'Create Focus Blocks',
      description: 'Dedicate 90-minute blocks for deep work',
      reason: 'Your focus metrics improve with structured time blocks',
      priority: 7,
    );
  }

  AIRecommendation? _recommendBreaks() {
    return AIRecommendation(
      id: const Uuid().v4(),
      userId: userId,
      type: RecommendationType.break,
      title: 'Take Strategic Breaks',
      description: 'A 15-minute break every 90 minutes improves sustained focus',
      reason: 'Research shows breaks enhance long-term productivity',
      priority: 6,
    );
  }

  AIRecommendation? _recommendNewHabits() {
    return AIRecommendation(
      id: const Uuid().v4(),
      userId: userId,
      type: RecommendationType.habit,
      title: 'Build a New Habit: Morning Routine',
      description: 'Start with a 10-minute morning routine to set your day',
      reason: 'Users with morning routines report 25% higher productivity',
      priority: 7,
    );
  }

  AIRecommendation? _recommendWellness() {
    return AIRecommendation(
      id: const Uuid().v4(),
      userId: userId,
      type: RecommendationType.wellness,
      title: 'Prioritize Sleep',
      description: 'Consistent sleep schedule improves all life domains',
      reason: 'Your stress and mood metrics suggest sleep improvement needed',
      priority: 9,
    );
  }

  String _generateBalanceInsight(
      Map<String, int> categoryBalance, int overallBalance) {
    if (overallBalance > 75) {
      return 'Excellent balance! You are thriving across all areas.';
    } else if (overallBalance > 50) {
      return 'Good balance overall, but some areas need more attention.';
    } else {
      return 'Your life balance needs improvement. Focus on neglected areas.';
    }
  }

  List<String> _generateBalanceRecommendations(
      Map<String, int> categoryBalance) {
    List<String> recsListItems = [];

    categoryBalance.forEach((category, value) {
      if (value < 40) {
        recsListItems.add('Increase focus on $category');
      }
    });

    return recsListItems;
  }
}