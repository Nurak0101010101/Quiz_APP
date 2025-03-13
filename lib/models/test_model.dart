class Test {
  final String title;
  final String category;
  final List<Question> questions;

  Test({required this.title, required this.category, required this.questions});
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
  });
}
