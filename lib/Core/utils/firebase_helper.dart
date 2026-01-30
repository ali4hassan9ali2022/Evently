import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseHelper {
  static List<EventModel> events = [];
  static Stream<List<EventModel>> getEvents() {
    CollectionReference event = FirebaseFirestore.instance.collection("events");

    return event.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data()))
          .toList();
    });
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static deleteEvent({
    required BuildContext context,
    required EventModel eventModel,
  }) async {
    try {
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection("events");
      collectionReference.doc(eventModel.id).delete();
      CustomToastWidget.showSuccessToast("Event deleted successfully");
      GoRouter.of(context).pop();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    }
  }

  static Stream<EventModel> getEventById(String id) {
    return FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .snapshots()
        .map((doc) => EventModel.fromJson(doc.data()));
  }
}
