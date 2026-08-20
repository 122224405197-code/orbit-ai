enum RecommendationType {
  habit,
  goal,
  focus,
  break,
  exercise,
  sleep,
  social,
  learning,
  financial,
  wellness,
}

class AIRecommendation {
  final String id;
  final String userId;
  final RecommendationType type;
  final String title;
  final String description;
  final String reason; // why this recommendation
  final int priority; // 1-10
  final DateTime generatedAt;
  final DateTime? expiresAt;
  bool isActioned;
  final String? actionTaken;

  AIRecommendation({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.description,
    required this.reason,
    required this.priority,
    DateTime? generatedAt,
    this.expiresAt,
    this.isActioned = false,
    this.actionTaken,
  }) : generatedAt = generatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.toString(),
      'title': title,
      'description': description,
      'reason': reason,
      'priority': priority,
      'generatedAt': generatedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isActioned': isActioned,
      'actionTaken': actionTaken,
    };
  }

  factory AIRecommendation.fromJson(Map<String, dynamic> json) {
    return AIRecommendation(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: RecommendationType.values.firstWhere(
          (e) => e.toString() == json['type'],
          orElse: () => RecommendationType.habit),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      reason: json['reason'] ?? '',
      priority: json['priority'] ?? 5,
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'])
          : DateTime.now(),
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      isActioned: json['isActioned'] ?? false,
      actionTaken: json['actionTaken'],
    );
  }
}