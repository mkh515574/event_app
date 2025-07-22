import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/utils/app_colors.dart';
import 'package:event_app/features/auth/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/app_route.dart';
import '../../home/controller/home_provider.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? user;
  List<UserModel> userData = [];
  bool isLoading = false;

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  void _showToast(String msg, {Color? bgColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: bgColor ?? AppColors.primaryLightColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showSnackBar(BuildContext context, String msg, {Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: bgColor ?? AppColors.primaryLightColor,
      ),
    );
  }

  void getAllUsers() {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    getUserCollection()
        .where("user_id", isEqualTo: currentUser.uid)
        .snapshots()
        .listen((querySnapshot) {
          userData = querySnapshot.docs.map((doc) => doc.data()).toList();
          notifyListeners();
        });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        _showToast("Google sign-in cancelled");
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        _showToast("Failed to sign in with Google");
        return;
      }

      final uid = firebaseUser.uid;

      // Check if user already exists
      final doc = await getUserCollection().doc(uid).get();
      if (!doc.exists) {
        await getUserCollection()
            .doc(uid)
            .set(
              UserModel(
                name: firebaseUser.displayName ?? '',
                email: firebaseUser.email ?? '',
                userId: uid,
                userImage: firebaseUser.photoURL ?? '',
                createdAt: FieldValue.serverTimestamp().toString(),
              ),
            );
      }


      _showToast("Account Created Successfully");

      Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
    } catch (e) {
      _showToast("Sign-in failed: ${e.toString()}", bgColor: Colors.red);
    }

    notifyListeners();
  }

  Future<void> createAccount({
    required String emailAddress,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        _showSnackBar(context, 'Account creation failed');
        return;
      }

      final uid = firebaseUser.uid;

      await getUserCollection()
          .doc(uid)
          .set(
            UserModel(
              name: name,
              email: emailAddress,
              userId: uid,
              createdAt: FieldValue.serverTimestamp().toString(),
            ),
          );

      _showToast("Account Created Successfully");


      Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context, e.message ?? 'Registration failed');
    } catch (e) {
      _showSnackBar(context, 'Something went wrong');
      debugPrint("Error: $e");
    }

    notifyListeners();
  }

  Future<void> fullSignOut(context) async {
    await _auth.signOut();

    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    var homeProvider = Provider.of<HomeProvider>(context, listen: false);
    userData = [];

    homeProvider.clearData();
    user = null;
    notifyListeners();
  }

  Future<void> login({
    required String emailAddress,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      _showToast("Login Successfully");

      Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
      }
      _showSnackBar(context, errorMessage);
    } catch (e) {
      debugPrint("Login error: $e");
      _showSnackBar(context, 'Something went wrong');
    }

    notifyListeners();
  }
}
