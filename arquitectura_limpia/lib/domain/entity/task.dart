class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
}