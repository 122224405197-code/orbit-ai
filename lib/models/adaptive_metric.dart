enum MetricType {
  custom,
  energy,
  mood,
  focus,
  stress,
  productivity,
  health,
  relationships,
  learning,
  financial,
  creativity,
  spiritualWellbeing,
}

class AdaptiveMetric {
  final String id;
  final String userId;
  final String name;
  final MetricType type;
  final String category; // user-defined
  final int value; // 0-100 scale
  final String unit;
  final DateTime timestamp;
  final String? note;
  final Map<String, dynamic> contextData;

  AdaptiveMetric({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.category,
    required this.value,
    this.unit = '',
    DateTime? timestamp,
    this.note,
    this.contextData = const {},
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'type': type.toString(),
      'category': category,
      'value': value,
      'unit': unit,
      'timestamp': timestamp.toIso8601String(),
      'note': note,
      'contextData': contextData,
    };
  }

  factory AdaptiveMetric.fromJson(Map<String, dynamic> json) {
    return AdaptiveMetric(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      type: MetricType.values.firstWhere(
          (e) => e.toString() == json['type'],
          orElse: () => MetricType.custom),
      category: json['category'] ?? '',
      value: json['value'] ?? 0,
      unit: json['unit'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      note: json['note'],
      contextData: json['contextData'] as Map<String, dynamic>? ?? {},
    );
  }
}