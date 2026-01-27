import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseHelper {
  static List<EventModel> events = [];
  static Future<List<EventModel>> getEvents() async {
    events.clear();
    CollectionReference event = FirebaseFirestore.instance.collection("events");
    QuerySnapshot querySnapshot = await event.get();
    for (var doc in querySnapshot.docs) {
      events.add(EventModel.fromJson(doc.data()));
    }
    log(events.toString());
    log("Get Events Done");
    log("Events = ${events.length}");
    return events;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser == null) {
      log("Google User is null");
    }
    final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
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
}
