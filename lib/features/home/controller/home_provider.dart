import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../events/model/event_model.dart';

class HomeProvider extends ChangeNotifier {
  List<EventModel> events = [];
  List<EventModel> favoriteEvents = [];

  static List<Map<String, IconData>> getCategories(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return [
      {'All': Icons.all_out_sharp},
      {local.sports: Icons.directions_bike},
      {local.gaming: Icons.videogame_asset},
      {local.work_shop: Icons.build},
      {local.meeting: Icons.meeting_room},
      {local.holiday: Icons.beach_access},
      {local.birthday: Icons.cake},
      {local.eating: Icons.restaurant},
      {local.book_club: Icons.book},
      {local.exhibition: Icons.museum},
    ];
  }

  int selectedIndex = 0;
  void getAllEvents() async {

        await FireBaseUtils.getEventsCollection()
            .orderBy("date", descending: true)
            .snapshots().listen((querySnapshot) {
          events = querySnapshot.docs.map((doc) => doc.data()).toList();
          favoriteEvents = events;
          notifyListeners();
        });

  }

  void getFelteredEvents(String category) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FireBaseUtils.getEventsCollection()
            .where("category_name", isEqualTo: category)
            .get();
    favoriteEvents = querySnapshot.docs.map((e) {
      return e.data();
    }).toList();
    notifyListeners();
  }

  Future<void> updateEventFavoriteStatus(
    String eventId,
    bool isFavorite,
  ) async {
    await FireBaseUtils.getEventsCollection().doc(eventId).update({
      'is_favorite': isFavorite,
    });

    notifyListeners();
  }

  Future<void> deleteFieldFromDocument({
    required String eventId,
    required String fieldName,
  }) async {
    await FireBaseUtils.getEventsCollection().doc(eventId).delete();
    notifyListeners();
  }

  void setSelectedIndex(int index, BuildContext context) {
    selectedIndex = index;
    selectedIndex == 0
        ? getAllEvents()
        : getFelteredEvents(getCategories(context)[index].keys.first);

  }
}
