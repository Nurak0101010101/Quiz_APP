import 'dart:convert';

import 'question.dart';

class Answer {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String title;
  final bool isCorrect;
  final Question? question;

  Answer({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.title,
    required this.isCorrect,
    this.question,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      title: json['title'],
      isCorrect: json['isCorrect'],
      question: json['expand'] != null && json['expand']['question'] != null
          ? Question.fromJson(json['expand']['question'])
          : null,
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
      'isCorrect': isCorrect,
      'expand': question != null ? {'question': question!.toJson()} : null,
    };
  }
}
