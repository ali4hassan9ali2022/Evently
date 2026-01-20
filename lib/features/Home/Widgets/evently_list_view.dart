import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';

class EventlyListView extends StatelessWidget {
  const EventlyListView({super.key, this.physics, this.shrinkWrap});
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemCount: 10,
      itemBuilder: (context, index) {
        return EventlyWidget();
      },
    );
  }
}
