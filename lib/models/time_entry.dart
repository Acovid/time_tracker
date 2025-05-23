class TimeEntry {
  final String id;
  final String project;
  final String task;
  final double totalTime;
  final DateTime date;
  final String notes;

  TimeEntry({
    required this.id,
    required this.project,
    required this.task,
    required this.totalTime,
    required this.date,
    required this.notes,
  });
}
