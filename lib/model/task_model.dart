class TaskModel {
  String title;
  String date;
  String description;
  String? firstLetter;
  bool isDone;

  TaskModel(
      {required this.title,
      required this.date,
      required this.description,
      this.isDone = false});

  // Convert TaskModel to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'description': description,
      'isDone': isDone,
    };
  }

  // Create a TaskModel from a Map (JSON)
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      description: json['description'] ?? '',
      isDone: json['isDone'] ?? false,
    );
  }
}
