import 'quiz.dart';

class Question {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String title;
  final String img;
  final int seconds;
  final Quiz? quiz;
  List<dynamic>? answers; // Added field to store answer data

  Question({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.title,
    required this.img,
    required this.seconds,
    this.quiz,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      title: json['title'],
      img: json['img'] ?? '',
      seconds: json['seconds'] ?? 0,
      quiz: json['expand'] != null && json['expand']['quiz'] != null
          ? Quiz.fromJson(json['expand']['quiz'])
          : null,
      answers: json['answers'], // This might be null initially
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
      'img': img,
      'seconds': seconds,
      'expand': quiz != null ? {'quiz': quiz!.toJson()} : null,
      'answers': answers,
    };
  }
}