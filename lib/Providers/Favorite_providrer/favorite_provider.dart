import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Models/user_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  void addFavorite({required String eventId, required UserModel user}) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user");
    DocumentReference documentReference = collectionReference.doc(user.userId);
    List<String> favoriteEventIds = List.of(user.favoriteEvents);
    favoriteEventIds.add(eventId);
    user.favoriteEvents = favoriteEventIds;
    documentReference.update({"favorites": user.favoriteEvents});
    log("add favorite success");
    notifyListeners();
  }

  void deleteFavorite({required String eventId, required UserModel user}) {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("user");
    DocumentReference documentReference = collectionReference.doc(user.userId);
    user.favoriteEvents.remove(eventId);
    documentReference.update({"favorites": user.favoriteEvents});
    log("Delete favorite success");
    notifyListeners();
  }
}
