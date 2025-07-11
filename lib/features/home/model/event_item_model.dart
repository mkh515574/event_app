class EventItemModel{
  String title;
  String month;
  String day;

  bool isFavorite;
  String category;


  EventItemModel({
    required this.title,
    required this.month,
    required this.day,

    this.isFavorite = false,
    required this.category,
});
}