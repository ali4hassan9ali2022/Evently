import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Models/event_model.dart';

abstract class FirebaseHelper {
  static List<EventModel> events = [];
  static Future<List<EventModel>> getEvents() async {
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
}
