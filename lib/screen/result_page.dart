import 'package:flutter/material.dart';
import '../models/question_model.dart';

class ResultPage extends StatelessWidget {
  final List<Question> questions;
  final List<int> userAnswers;

  ResultPage({required this.questions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    List<Map<String, dynamic>> incorrectAnswers = [];

    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswerIndex) {
        correctAnswers++;
      } else {
        incorrectAnswers.add({
          "question": questions[i].text,
          "userAnswer": questions[i].answers[userAnswers[i]],
          "correctAnswer": questions[i].answers[questions[i].correctAnswerIndex],
        });
      }
    }

    double percentage = (correctAnswers / questions.length) * 100;

    return Scaffold(
      appBar: AppBar(title: Text("Результаты теста")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildResultCard(correctAnswers, questions.length, percentage),
            SizedBox(height: 20),
            if (incorrectAnswers.isNotEmpty) _buildMistakesList(incorrectAnswers),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Возвращаемся на предыдущую страницу
              },
              child: Text("Назад к тестам"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(int correct, int total, double percentage) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Ваш результат:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("${percentage.toStringAsFixed(1)}%", 
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            SizedBox(height: 10),
            Text("$correct из $total правильных", style: TextStyle(fontSize: 18, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildMistakesList(List<Map<String, dynamic>> incorrectAnswers) {
    return Expanded(
      child: ListView.builder(
        itemCount: incorrectAnswers.length,
        itemBuilder: (context, index) {
          var item = incorrectAnswers[index];
          return Card(
            child: ListTile(
              title: Text("Вопрос: ${item["question"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("❌ Ваш ответ: ${item["userAnswer"]}", style: TextStyle(color: Colors.red)),
                  Text("✅ Правильный ответ: ${item["correctAnswer"]}", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
