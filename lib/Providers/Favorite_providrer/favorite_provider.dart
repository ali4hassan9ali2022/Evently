import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<EventModel> favoriteEvents = [];
  List<EventModel> allFavoriteEvents = [];
  bool isLoading = false;
  void addFavorite({
    required String eventId,
    required UserModel user,
    required BuildContext context,
  }) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user");
    DocumentReference documentReference = collectionReference.doc(user.userId);
    List<String> favoriteEventIds = List.of(user.favoriteEvents);
    favoriteEventIds.add(eventId);
    user.favoriteEvents = favoriteEventIds;
    documentReference.update({"favorites": user.favoriteEvents});
    log("add favorite success");
    getFavoriteEvents(uid: user.userId, context: context);
    notifyListeners();
  }

  void deleteFavorite({
    required String eventId,
    required UserModel user,
    required BuildContext context,
  }) {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user");
    DocumentReference documentReference = collectionReference.doc(user.userId);
    user.favoriteEvents.remove(eventId);
    documentReference.update({"favorites": user.favoriteEvents});
    getFavoriteEvents(uid: user.userId, context: context);
    log("Delete favorite success");
    notifyListeners();
  }

  Future<List<EventModel>> getFavoriteEvents({
    required String uid,
    required BuildContext context,
  }) async {
    favoriteEvents.clear();
    allFavoriteEvents.clear();
    isLoading = true;

    var user = Provider.of<UserProvider>(context, listen: false);
    if (user.userModel!.favoriteEvents.isEmpty) {
      isLoading = false;
      notifyListeners();
      return [];
    }
    CollectionReference eventsCollection = FirebaseFirestore.instance
        .collection("events");
    QuerySnapshot querySnapshot = await eventsCollection
        .where("id", whereIn: user.userModel!.favoriteEvents)
        .get();

    for (var event in querySnapshot.docs) {
      final eventModel = EventModel.fromJson(event);
      allFavoriteEvents.add(eventModel);
    }
    favoriteEvents = List.from(allFavoriteEvents);
    isLoading = false;
    notifyListeners();
    log("favorites = ${favoriteEvents.length}");
    return favoriteEvents;
  }

  void searchFavorite({required String query}) {
    if (query.isEmpty) {
      favoriteEvents = List.from(allFavoriteEvents);
    } else {
      favoriteEvents = allFavoriteEvents.where((event) {
        return event.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
