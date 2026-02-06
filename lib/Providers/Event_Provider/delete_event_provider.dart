import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Core/Widgets/toast_widget.dart';
import 'package:evently/Core/utils/extensions.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Providers/Event_Provider/fetch_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeleteEventProvider extends ChangeNotifier {
  deleteEvent({
    required BuildContext context,
    required EventModel eventModel,
  }) async {
    try {
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection("events");
      collectionReference.doc(eventModel.id).delete();
      CustomToastWidget.showSuccessToast(context.loc.eventDeletedSuccessful);
      await Provider.of<FetchEventProvider>(context, listen: false).getEvents();
      GoRouter.of(context).pop();
      GoRouter.of(context).pop();
    } catch (e) {
      CustomToastWidget.showErrorToast(e.toString());
    }
  }

  // static Stream<EventModel> getEventById(String id) {
  //   return FirebaseFirestore.instance
  //       .collection('events')
  //       .doc(id)
  //       .snapshots()
  //       .map((doc) => EventModel.fromJson(doc.data()));
  // }
}
