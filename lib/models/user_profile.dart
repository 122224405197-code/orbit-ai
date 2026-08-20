enum UserLifestyle {
  balanced,
  workFocused,
  healthFocused,
  creativeFreelancer,
  student,
  entrepreneur,
  parent,
  retired,
}

enum UserGoal {
  productivity,
  wellness,
  fitness,
  learning,
  relationships,
  creativity,
  financial,
  spiritual,
}

class UserProfile {
  final String userId;
  final String name;
  final List<UserLifestyle> lifestyles;
  final List<UserGoal> priorities;
  final List<String> customCategories;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  bool isAIEnabled;
  bool allowsNotifications;
  String theme; // 'dark', 'light', 'auto'

  UserProfile({
    required this.userId,
    required this.name,
    required this.lifestyles,
    required this.priorities,
    this.customCategories = const [],
    this.preferences = const {},
    DateTime? createdAt,
    this.isAIEnabled = true,
    this.allowsNotifications = true,
    this.theme = 'dark',
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'lifestyles': lifestyles.map((e) => e.toString()).toList(),
      'priorities': priorities.map((e) => e.toString()).toList(),
      'customCategories': customCategories,
      'preferences': preferences,
      'createdAt': createdAt.toIso8601String(),
      'isAIEnabled': isAIEnabled,
      'allowsNotifications': allowsNotifications,
      'theme': theme,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      lifestyles: (json['lifestyles'] as List?)
              ?.map((e) => UserLifestyle.values.firstWhere(
                  (x) => x.toString() == e,
                  orElse: () => UserLifestyle.balanced))
              .toList() ??
          [],
      priorities: (json['priorities'] as List?)
              ?.map((e) => UserGoal.values.firstWhere(
                  (x) => x.toString() == e,
                  orElse: () => UserGoal.productivity))
              .toList() ??
          [],
      customCategories:
          List<String>.from(json['customCategories'] as List? ?? []),
      preferences: json['preferences'] as Map<String, dynamic>? ?? {},
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      isAIEnabled: json['isAIEnabled'] ?? true,
      allowsNotifications: json['allowsNotifications'] ?? true,
      theme: json['theme'] ?? 'dark',
    );
  }
}
