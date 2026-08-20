class Goal {
  final String id;
  final String title;
  final int progress; // 0-100
  final String category;

  Goal({
    required this.id,
    required this.title,
    required this.progress,
    required this.category,
  });
}