import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/app_helper.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddEventProvidr extends ChangeNotifier {
  CategoryModel selectCategory = AppHelper.customCategories[0];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  createEvent({required BuildContext context}) async {
    try {
      selectedDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      isLoading = true;
      notifyListeners();
      CollectionReference events = FirebaseFirestore.instance.collection(
        "events",
      );

      DocumentReference docu = events.doc();
      EventModel eventModel = EventModel(
        id: docu.id,
        ownerId: Provider.of<UserProvider>(
          context,
          listen: false,
        ).userModel!.userId,
        categoryModel: selectCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate!,
      );

      docu.set(eventModel.toJson());
      final fetchProvider = Provider.of<FetchEventProvider>(
        context,
        listen: false,
      );
      fetchProvider.events.add(eventModel);
      fetchProvider.filterEvents();
      CustomToastWidget.showSuccessToast("Event added successfully");
      await Provider.of<FetchEventProvider>(context, listen: false).getEvents();
      isLoading = false;
      notifyListeners();
      GoRouter.of(context).pop();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
      log("Error = $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //! Select Category
  void setSelectedCategory(CategoryModel category) {
    selectCategory = category;
    notifyListeners();
  }

  //! Select Data
  void selectData({required BuildContext context}) async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        ) ??
        selectedDate;
    notifyListeners();
  }

  //! Select Time
  void selectTime({required BuildContext context}) async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;
  }
}
