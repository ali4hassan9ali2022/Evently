import 'package:evently/Core/utils/app_color.dart';
import 'package:evently/Core/utils/app_styles.dart';
import 'package:evently/Models/event_model.dart';
import 'package:evently/Models/user_model.dart';
import 'package:evently/Providers/Auth_Provider/Auth_Provider.dart';
import 'package:evently/Providers/Favorite_providrer/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventlyWidget extends StatelessWidget {
  const EventlyWidget({
    super.key,
    required this.evvent,
    required this.userModel,
  });
  final EventModel evvent;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .30,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              evvent.categoryModel.imagePath,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.offWhite,
                  ),
                  child: Text(
                    "${evvent.dateTime.day} Jan",
                    textAlign: TextAlign.start,
                    style: AppStyles.textStyleRegular16().copyWith(
                      color: AppColor.blue,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.offWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          evvent.title,
                          style: AppStyles.textStyleMedium14(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Consumer<FavoriteProvider>(
                        builder: (context, value, child) {
                          return InkWell(
                            onTap: () {
                              if (Provider.of<UserProvider>(
                                context,
                                listen: false,
                              ).userModel!.favoriteEvents.contains(evvent.id)) {
                                value.deleteFavorite(
                                  eventId: evvent.id,
                                  user: userModel,
                                  context: context,
                                );
                              } else {
                                value.addFavorite(
                                  eventId: evvent.id,
                                  user: userModel,
                                  context: context,
                                );
                              }
                            },
                            child: Icon(
                              Provider.of<UserProvider>(context, listen: false)
                                      .userModel!
                                      .favoriteEvents
                                      .contains(evvent.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppColor.blue,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
