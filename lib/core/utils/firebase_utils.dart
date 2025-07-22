import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/events/model/event_model.dart';

class FireBaseUtils{

 static CollectionReference<EventModel> getEventsCollection(){
  return  FirebaseFirestore.instance.collection(EventModel.collectionName).withConverter<EventModel>(
      fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
      toFirestore: (e, _) => e.toJson(),
    );
  }

  static Future<void> addEvent(EventModel event){
    DocumentReference<EventModel> doc =  getEventsCollection().doc();
    event.id = doc.id;
    return doc.set(event);



  }


}