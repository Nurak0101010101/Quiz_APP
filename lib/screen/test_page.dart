import 'package:flutter/material.dart';
import '../models/test_model.dart';
import 'result_page.dart';

class TestPage extends StatefulWidget {
  final Test test;

  TestPage({required this.test});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  String? selectedAnswer;
  bool isAnswered = false;

  void checkAnswer() {
    if (selectedAnswer == widget.test.questions[currentQuestionIndex].correctAnswer) {
      correctAnswers++;
    }
    setState(() {
      isAnswered = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex + 1 < widget.test.questions.length) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        isAnswered = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            correctAnswers: correctAnswers,
            totalQuestions: widget.test.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.test.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.test.title)),
        body: Center(child: Text("В этом тесте пока нет вопросов.")),
      );
    }

    Question currentQuestion = widget.test.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.test.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Вопрос ${currentQuestionIndex + 1} из ${widget.test.questions.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(currentQuestion.questionText, style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            Column(
              children: currentQuestion.options.map((option) {
                return GestureDetector(
                  onTap: () {
                    if (!isAnswered) {
                      setState(() {
                        selectedAnswer = option;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isAnswered
                          ? (option == currentQuestion.correctAnswer ? Colors.green : (option == selectedAnswer ? Colors.red : Colors.white))
                          : (option == selectedAnswer ? Colors.blue.withOpacity(0.5) : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(option, style: TextStyle(fontSize: 18)),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: selectedAnswer == null ? null : (isAnswered ? nextQuestion : checkAnswer),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text(isAnswered ? (currentQuestionIndex + 1 < widget.test.questions.length ? "Далее" : "Завершить") : "Проверить"),
            ),
          ],
        ),
      ),
    );
  }
}


