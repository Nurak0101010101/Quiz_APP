import 'dart:convert';

class Quiz {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String title;
  final String subtitle;
  final String difficulty;
  final String category;

  Quiz({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.title,
    required this.subtitle,
    required this.difficulty,
    required this.category,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      title: json['title'],
      subtitle: json['subtitle'],
      difficulty: json['difficulty'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'title': title,
      'subtitle': subtitle,
      'difficulty': difficulty,
      'category': category,
    };
  }
}
