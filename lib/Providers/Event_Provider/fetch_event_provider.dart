import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
import 'package:flutter/material.dart';

class FetchEventProvider extends ChangeNotifier {
  CategoryModel selectedCategory = AppHelper.all;
  List<EventModel> filteredEvents = [];
  List<EventModel> events = [];
  List<EventModel> myEvents = [];
  bool isLoading = false;
  //! Get Events
  Future<List<EventModel>> getEvents() async {
    events.clear();
    isLoading = true;
    notifyListeners();
    CollectionReference eventCollection = FirebaseFirestore.instance.collection(
      "events",
    );
    QuerySnapshot querySnapshot = await eventCollection.get();
    for (var event in querySnapshot.docs) {
      events.add(EventModel.fromJson(event));
    }
    filterEvents();
    isLoading = false;
    notifyListeners();
    log("Fetch events = ${events.length}");
    return events;
  }

  //! Filter Events
  void filterEvents() {
    if (selectedCategory != AppHelper.all) {
      filteredEvents = events.where((event) {
        return event.categoryModel.name == selectedCategory.name;
      }).toList();
      log(filteredEvents.length.toString());
      notifyListeners();
    } else {
      filteredEvents = events;
      notifyListeners();
    }
  }

  //! Update Event
  //! Select Category
  void setSelectedCategory(CategoryModel category) {
    selectedCategory = category;
    filterEvents();
    notifyListeners();
  }

  //! Fetch My Events

  bool isLoadingGetMyEvents = false;
  Future<List<EventModel>> getMyEvents(String userId) async {
    myEvents.clear();
    isLoadingGetMyEvents = true;
    try {
      CollectionReference eventCollection = FirebaseFirestore.instance
          .collection("events");
      QuerySnapshot querySnapshot = await eventCollection
          .where("ownerId", isEqualTo: userId)
          .get();
      for (var event in querySnapshot.docs) {
        myEvents.add(EventModel.fromJson(event));
      }
      log("Fetch events = ${myEvents.length}");
      return myEvents;
    } catch (e) {
      isLoadingGetMyEvents = false;
      notifyListeners();
      CustomToastWidget.showErrorToast(e.toString());
      return [];
    } finally {
      isLoadingGetMyEvents = false;
      notifyListeners();
    }
  }
}
