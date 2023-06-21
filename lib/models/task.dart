enum Priority {
  none,
  high,
  low,
}

class Task {
  final String id;
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final Priority priority;
  bool isChecked;

  Task({
    required this.id,
    required this.description,
    required this.createdAt,
    this.dueDate,
    this.priority = Priority.none,
    this.isChecked = false,
  });

  @override
  String toString() {
    return 'description: $description, dueDate: $dueDate, isChecked: $isChecked, Priority: $priority,';
  }
}
