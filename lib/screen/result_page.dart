import 'package:flutter/material.dart';
import '../models/question.dart';

class ResultPage extends StatelessWidget {
  final List<Question> questions;
  final List<Map<String, dynamic>> results;
  final int correctCount;
  final int totalCount;

  ResultPage({
    required this.questions, 
    required this.results,
    required this.correctCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (correctCount / totalCount) * 100;
    
    return Scaffold(
      appBar: AppBar(title: Text("Результаты теста")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildResultCard(correctCount, totalCount, percentage),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final result = results[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                result["isCorrect"] ? Icons.check_circle : Icons.cancel,
                                color: result["isCorrect"] ? Colors.green : Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Вопрос ${index + 1}: ${result["question"]}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Ваш ответ: ${result["userAnswer"]}",
                            style: TextStyle(
                              color: result["isCorrect"] ? Colors.green : Colors.red,
                              fontSize: 15,
                            ),
                          ),
                          if (!result["isCorrect"])
                            Text(
                              "Правильный ответ: ${result["correctAnswer"]}",
                              style: TextStyle(color: Colors.green, fontSize: 15),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Назад к тестам"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(int correct, int total, double percentage) {
    Color resultColor;
    String resultText;
    
    if (percentage >= 80) {
      resultColor = Colors.green;
      resultText = "Отлично!";
    } else if (percentage >= 60) {
      resultColor = Colors.orange;
      resultText = "Хорошо";
    } else {
      resultColor = Colors.red;
      resultText = "Нужно подтянуть";
    }
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Ваш результат:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: resultColor.withOpacity(0.2),
              child: Text(
                "${percentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              resultText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: resultColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "$correct из $total правильных",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}