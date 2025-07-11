import '../../features/home/model/event_item_model.dart';

class ListOfEvents {

  static List<EventItemModel> events = [
    EventItemModel(
      title: 'This is a Birthday Party',
      month: 'May',
      day: '21',
      category: 'Birthday',
      isFavorite: true,

    ),

    EventItemModel(
      title: 'Meeting for Updating The Development Method ',
      month: 'Nov',
      day: '22',
      category: 'Meeting',
      isFavorite: true,

    ),
    EventItemModel(
      title: 'Sports Event',
      month: "Jun",
      day: '15',
      category: 'Sports',
      isFavorite: true,

    ),
    EventItemModel(
      title: 'Meeting for Updating The Development Method ',
      month: 'Nov',
      day: '22',
      category: 'Meeting',
      isFavorite: false,

    ),
    EventItemModel(
      title: 'Meeting for Updating The Development Method ',
      month: 'Nov',
      day: '22',
      category: 'Meeting',
      isFavorite: false,

    ),
  ];
}
