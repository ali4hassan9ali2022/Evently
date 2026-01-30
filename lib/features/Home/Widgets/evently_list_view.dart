import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventlyListView extends StatelessWidget {
  const EventlyListView({
    super.key,
    this.physics,
    this.shrinkWrap,
    this.itemCount,
    required this.evvent,
  });
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  final int? itemCount;
  final List<EventModel> evvent;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(
              context,
            ).push(AppRouter.eventDetails, extra: evvent[index]);
          },
          child: EventlyWidget(evvent: evvent[index]),
        );
      },
    );
  }
}
