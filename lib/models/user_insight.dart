class UserInsight {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String category; // 'productivity', 'health', 'balance', etc.
  final DateTime generatedAt;
  final Map<String, dynamic> data;
  final List<String> actionableSteps;

  UserInsight({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    DateTime? generatedAt,
    this.data = const {},
    this.actionableSteps = const [],
  }) : generatedAt = generatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'category': category,
      'generatedAt': generatedAt.toIso8601String(),
      'data': data,
      'actionableSteps': actionableSteps,
    };
  }

  factory UserInsight.fromJson(Map<String, dynamic> json) {
    return UserInsight(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      generatedAt: json['generatedAt'] != null
          ? DateTime.parse(json['generatedAt'])
          : DateTime.now(),
      data: json['data'] as Map<String, dynamic>? ?? {},
      actionableSteps:
          List<String>.from(json['actionableSteps'] as List? ?? []),
    );
  }
}