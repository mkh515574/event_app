import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/events/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseUtils{

 static CollectionReference<EventModel> getEventsCollection(){
  return  FirebaseFirestore.instance.collection(EventModel.collectionName).withConverter<EventModel>(
      fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
      toFirestore: (e, _) => e.toJson(),
    );
  }

  static Future<void> addEvent(EventModel event){
    final user = FirebaseAuth.instance.currentUser;
    DocumentReference<EventModel> doc =  getEventsCollection().doc();
    event.id = doc.id;
    event.userId = user!.uid;

    return doc.set(event);



  }
  static Future<void> updateEvent(EventModel event){
    return getEventsCollection().doc(event.id).update(event.toJson());
  }

  static Future<void> deleteEvent(String eventId){
    return getEventsCollection().doc(eventId).delete();
  }


 void currentUserData() async {
   final user = FirebaseAuth.instance.currentUser;

   if (user != null) {
     String uid = user.uid;
     print("User ID: $uid");
   } else {
     print("No user is signed in.");
   }
 }


}