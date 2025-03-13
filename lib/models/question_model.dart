class Question {
  final String text; // Текст вопроса
  final List<String> answers; // Список ответов
  final int correctAnswerIndex; // Индекс правильного ответа

  Question({
    required this.text,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
