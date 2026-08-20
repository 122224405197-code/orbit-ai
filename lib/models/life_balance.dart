class LifeBalance {
  final String userId;
  final DateTime date;
  final Map<String, int> categoryBalance; // category -> percentage
  final int overallBalance; // 0-100
  final String insight;
  final List<String> recommendations;

  LifeBalance({
    required this.userId,
    required this.date,
    required this.categoryBalance,
    required this.overallBalance,
    required this.insight,
    this.recommendations = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'categoryBalance': categoryBalance,
      'overallBalance': overallBalance,
      'insight': insight,
      'recommendations': recommendations,
    };
  }

  factory LifeBalance.fromJson(Map<String, dynamic> json) {
    return LifeBalance(
      userId: json['userId'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      categoryBalance:
          Map<String, int>.from(json['categoryBalance'] as Map? ?? {}),
      overallBalance: json['overallBalance'] ?? 0,
      insight: json['insight'] ?? '',
      recommendations:
          List<String>.from(json['recommendations'] as List? ?? []),
    );
  }
}