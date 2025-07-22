import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/utils/app_route.dart';

class AuthController extends ChangeNotifier {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (e, _) => e.toJson(),
        );
  }

  UserModel? user;

  bool isLoading = false;

  Future<void> getUserData() async {
    isLoading = true;
    notifyListeners();

    String? userId = FirebaseAuth.instance.currentUser?.uid;


    if (userId != null) {
      QuerySnapshot<UserModel> snapshot = await getUserCollection()
          .where("user_id", isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        user = snapshot.docs.first.data();

        print(user.toString());
        isLoading = false;
        notifyListeners();
      }
    }
  }

  static Future<void> addEvent(UserModel user) {
    DocumentReference<UserModel> doc = getUserCollection().doc();

    return doc.set(user);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> createAccount({
    required String emailAddress,
    required String password,
    required String name,
    required BuildContext context, // ← Add this
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

      String uid = userCredential.user!.uid;

      getUserCollection()
          .doc(uid)
          .set(
            UserModel(
              name: name,
              email: emailAddress,
              userId: uid,
              createdAt: FieldValue.serverTimestamp().toString(),
            ),
          );

      Fluttertoast.showToast(
        msg: "Account Created Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryLightColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushReplacementNamed(
        context,
        AppRoute.homeRouteName,
      ); // or any route
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'Registration failed';
      debugPrint("FirebaseAuthException: $errorMessage");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      debugPrint("General Error: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong.')));
    }
  }

  Future<void> login({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryLightColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );


      Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided.';
      } else {
        errorMessage = e.message ?? 'An error occurred';
      }

      // ❌ Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.primaryLightColor,
        ),
      );
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryLightColor,

          content: Text('Something went wrong.'),
        ),
      );
    }
  }
}
