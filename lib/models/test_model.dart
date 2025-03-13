import 'question_model.dart';

class Test {
  final String title; // Название теста
  final String category; // Категория теста
  final List<Question> questions; // Вопросы теста

  Test({
    required this.title,
    required this.category,
    required this.questions,
  });
}
