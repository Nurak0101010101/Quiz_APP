import 'package:flutter/material.dart';
import '../models/test_model.dart';

class TestPage extends StatefulWidget {
  final Test test;
  TestPage({required this.test});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _currentQuestionIndex = 0;
  Map<int, int?> _answers = {}; // Ответы пользователя

  @override
  Widget build(BuildContext context) {
    var question = widget.test.questions[_currentQuestionIndex];
    double progress = (_currentQuestionIndex + 1) / widget.test.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Прогресс-бар
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 8,
            ),
            SizedBox(height: 16),
            Text(
              "Вопрос ${_currentQuestionIndex + 1} из ${widget.test.questions.length}",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              question.text,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Варианты ответов
            Expanded(
              child: ListView(
                children: List.generate(question.answers.length, (index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: RadioListTile<int>(
                      title: Text(
                        question.answers[index],
                        style: TextStyle(fontSize: 18),
                      ),
                      value: index,
                      groupValue: _answers[_currentQuestionIndex],
                      onChanged: (value) {
                        setState(() {
                          _answers[_currentQuestionIndex] = value;
                        });
                      },
                    ),
                  );
                }),
              ),
            ),

            // Кнопки "Назад" и "Далее"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Кнопка "Назад"
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    },
                    child: Text("Назад"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),

                // Кнопка "Далее" или "Завершить"
                ElevatedButton(
                  onPressed: () {
                    if (_currentQuestionIndex < widget.test.questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                      });
                    } else {
                      _showResults();
                    }
                  },
                  child: Text(_currentQuestionIndex == widget.test.questions.length - 1 ? "Завершить" : "Далее"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Окно с результатами
  void _showResults() {
    int correctAnswers = 0;
    List<Widget> resultsList = [];

    for (int i = 0; i < widget.test.questions.length; i++) {
      bool isCorrect = _answers[i] == widget.test.questions[i].correctAnswerIndex;
      if (isCorrect) correctAnswers++;

      resultsList.add(
        ListTile(
          title: Text(
            widget.test.questions[i].text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ваш ответ: ${_answers[i] != null ? widget.test.questions[i].answers[_answers[i]!] : "Не выбрано"}"),
              Text("Правильный ответ: ${widget.test.questions[i].answers[widget.test.questions[i].correctAnswerIndex]}",
                  style: TextStyle(color: Colors.green)),
            ],
          ),
          trailing: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
          ),
        ),
      );
    }

    double percentage = (correctAnswers / widget.test.questions.length) * 100;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Результат"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text("Вы правильно ответили на $correctAnswers из ${widget.test.questions.length} вопросов."),
                SizedBox(height: 8),
                Text("Процент правильных ответов: ${percentage.toStringAsFixed(1)}%"),
                SizedBox(height: 10),
                Divider(),
                Column(children: resultsList), // Показываем список вопросов с ответами
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Ок"),
            ),
          ],
        );
      },
    );
  }
}

