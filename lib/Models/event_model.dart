import 'package:evently/Models/category_model.dart';

class EventModel {
  final CategoryModel categoryModel;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isFavorite;

  EventModel({
    required this.categoryModel,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isFavorite,
  });
}
