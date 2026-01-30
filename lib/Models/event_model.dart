import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Models/category_model.dart';

class EventModel {
  String id;
  final String ownerId;
  final CategoryModel categoryModel;
  final String title;
  final String description;
  final DateTime dateTime;

  EventModel({
    required this.id,
    required this.ownerId,
    required this.categoryModel,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  toJson() {
    return {
      "id": id,
      'ownerId': ownerId,
      'categoryModel': categoryModel.toJson(),
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }

  factory EventModel.fromJson(json) {
    return EventModel(
      id: json['id'],
      ownerId: json['ownerId'],
      categoryModel: CategoryModel.fromJson(json['categoryModel']),
      title: json['title'],
      description: json['description'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
    );
  }
}
