import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier{

  static CollectionReference<UserModel> getEventsCollection(){
    return  FirebaseFirestore.instance.collection(UserModel.collectionName).withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (e, _) => e.toJson(),
    );
  }

  static Future<void> addEvent(UserModel user){

    DocumentReference<UserModel> doc =  getEventsCollection().doc();


    return doc.set(user);



  }



  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createAccount({
    required String emailAddress,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Example: save name and email to Firestore or any DB
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': emailAddress,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Optional: navigate or show success
      debugPrint("User created with UID: $uid");

    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: ${e.message}");
      // show a SnackBar or dialog to the user
    } catch (e) {
      debugPrint("General Error: $e");
    }
  }

  Future<void> login({required String emailAddress, required String password})async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

    }
  }
}


