import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/servise/pocketbase_service.dart';

class QuizDetailPage extends StatefulWidget {
  final String id;
  const QuizDetailPage({super.key, required this.id});

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  late Future<Question> questions;
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData(){
    final record = pocketBaseService.pb.collection('quizapp_questions').getOne(widget.id);
    print(record);
    return record;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id),),
    );
  }
}