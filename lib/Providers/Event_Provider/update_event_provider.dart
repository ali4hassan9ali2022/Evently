import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UpdateEventProvider extends ChangeNotifier {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late CategoryModel selectCategory;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool isLoading = false;
  void init(EventModel event) {
    titleController = TextEditingController(text: event.title);
    descriptionController = TextEditingController(text: event.description);
    selectCategory = event.categoryModel;
    selectedDate = event.dateTime;
    selectedTime = TimeOfDay(
      hour: event.dateTime.hour,
      minute: event.dateTime.minute,
    );
  }

  void updateCategory(CategoryModel category) {
    selectCategory = category;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }

  Future<void> updateEvent({
    required String id,
    required String ownerId,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final updatedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      CollectionReference event = FirebaseFirestore.instance.collection(
        "events",
      );
      await event.doc(id).update({
        "title": titleController.text,
        "description": descriptionController.text,
        "dateTime": updatedDateTime,
        "categoryModel": selectCategory.toJson(),
        "ownerId": ownerId,
      });
      CustomToastWidget.showSuccessToast(context.loc.eventUpdatedSuccessful);
      await Provider.of<FetchEventProvider>(context, listen: false).getEvents();
      GoRouter.of(context).pop();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
