import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';

class EventlyListView extends StatelessWidget {
  const EventlyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return EventlyWidget();
      },
    );
  }
}
