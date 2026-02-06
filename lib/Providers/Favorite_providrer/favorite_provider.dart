import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<EventModel> filterFavoriteEvents = [];
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
    CustomToastWidget.showSuccessToast(context.loc.eventAddedToFavoritesSuccessful);
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
    CustomToastWidget.showErrorToast(context.loc.eventDeletedToFavoritesSuccessful);
    notifyListeners();
  }

  Future<List<EventModel>> getFavoriteEvents({
    required String uid,
    required BuildContext context,
  }) async {
    filterFavoriteEvents.clear();
    allFavoriteEvents.clear();
    isLoading = true;

    var user = Provider.of<UserProvider>(context, listen: false);
    if (user.userModel!.favoriteEvents.isEmpty) {
      isLoading = false;
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
    filterFavoriteEvents = List.from(allFavoriteEvents);
    isLoading = false;
    notifyListeners();
    log("favorites = ${filterFavoriteEvents.length}");
    return filterFavoriteEvents;
  }

  void searchFavorite({required String query}) {
    if (query.isEmpty) {
      filterFavoriteEvents = List.from(allFavoriteEvents);
    } else {
      filterFavoriteEvents = allFavoriteEvents.where((event) {
        return event.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
