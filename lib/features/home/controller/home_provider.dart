import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var auth = FirebaseAuth.instance.currentUser;

  int selectedIndex = 0;
  StreamSubscription<QuerySnapshot<EventModel>>? _eventsSubscription;

  void getAllEvents() {
    _eventsSubscription?.cancel();

    _eventsSubscription = FireBaseUtils.getEventsCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((querySnapshot) {
          events = querySnapshot.docs.map((doc) => doc.data()).toList();
          favoriteEvents = events;
          notifyListeners();
        });
  }

  void clearData() {
    events = [];
    favoriteEvents = [];
    _eventsSubscription?.cancel();
    _eventsSubscription = null;
    notifyListeners();
  }

  void getFelteredEvents(String category) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FireBaseUtils.getEventsCollection()
            .where("category_name", isEqualTo: category)
            .where("userId", isEqualTo: auth!.uid)
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

  void deleteEvent(String eventId, context) {
    FireBaseUtils.deleteEvent(eventId).then((val) {
      Navigator.pop(context);
    });
  }

  void setSelectedIndex(int index, BuildContext context) {
    selectedIndex = index;
    selectedIndex == 0
        ? getAllEvents()
        : getFelteredEvents(getCategories(context)[index].keys.first);
  }
}
