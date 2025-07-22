

class EventModel {
  static const String collectionName = "Events";
  String title;
  String id;
  String? userId;
  String imagePath;
  String description;
  String categoryName;
  DateTime date;
  String timeOfDay;
  bool isFavorite;

  EventModel({
    required this.title,
    this.id = "",
    this.userId = "",
    required this.imagePath,
    required this.timeOfDay,
    required this.description,
    required this.categoryName,
    required this.date,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'title': title,
      'description': description,
      'category_name': categoryName,
      'date': date.millisecondsSinceEpoch,
      'time_of_day': timeOfDay,
      'is_favorite': isFavorite,
      'userId': userId,
    };
  }

  EventModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        imagePath: json['image_path'],
        title: json['title'],
        description: json['description'],
        categoryName: json['category_name'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        isFavorite: json['is_favorite'],
        userId: json['userId'],
        timeOfDay: json['time_of_day'],
      );
}
