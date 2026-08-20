class Habit {
  final String id;
  final String title;
  final String duration;
  bool isCompleted;

  Habit({
    required this.id,
    required this.title,
    required this.duration,
    this.isCompleted = false,
  });
}