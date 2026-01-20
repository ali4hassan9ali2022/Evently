import 'package:evently/Core/utils/app_assets.dart';
import 'package:evently/Core/utils/app_router.dart';
import 'package:evently/Models/category_model.dart';
import 'package:evently/Models/event_model.dart';
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
      itemCount: 10,
      itemBuilder: (context, index) {
        var category = CategoryModel(
          name: "Sports",
          imagePath: AppAssets.imagesSport1,
          icon: Icons.bike_scooter,
        );
        var event = EventModel(
          categoryModel: category,
          dateTime: DateTime.now(),
          title: "Meeting for Updating The Development Method ",
          description:
              "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
          isFavorite: false,
        );
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.eventDetails, extra: event);
          },
          child: EventlyWidget(evvent: event),
        );
      },
    );
  }
}
