import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
import 'package:flutter/material.dart';

class FetchEventProvider extends ChangeNotifier {
  CategoryModel selectedCategory = AppHelper.all;
  List<EventModel> filteredEvents = [];
  List<EventModel> events = [];
  bool isLoading = false;
  Future<List<EventModel>> getEvents() async {
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

  void setSelectedCategory(CategoryModel category) {
    selectedCategory = category;
    filterEvents();
    notifyListeners();
  }
}
