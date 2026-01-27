import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Core/utils/firebase_helper.dart';
import 'package:evently/features/Home/Widgets/evently_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventlyListView extends StatelessWidget {
  const EventlyListView({super.key, this.physics, this.shrinkWrap});
  final ScrollPhysics? physics;
  final bool? shrinkWrap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap ?? false,
      itemCount: FirebaseHelper.events.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(
              context,
            ).push(AppRouter.eventDetails, extra: FirebaseHelper.events);
          },
          child: EventlyWidget(evvent: FirebaseHelper.events[index]),
        );
      },
    );
  }
}
