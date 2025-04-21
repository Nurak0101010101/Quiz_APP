import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screen/result_page.dart';

class TestPage extends StatefulWidget {
  final Quiz quiz;
  final List<Question> questions;
  
  TestPage({required this.quiz, required this.questions});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _currentQuestionIndex = 0;
  Map<int, int?> _answers = {}; // User answers
  bool _isLoading = false;
  Map<String, List<dynamic>> _questionsWithAnswers = {};
  int _secondsRemaining = 0;
  bool _isTimerActive = false;
  
  @override
  void initState() {
    super.initState();
    _initTimer();
  }
  
  void _initTimer() {
    if (widget.questions.isNotEmpty && widget.questions[_currentQuestionIndex].seconds > 0) {
      _secondsRemaining = widget.questions[_currentQuestionIndex].seconds;
      _startTimer();
    }
  }
  
  void _startTimer() {
    _isTimerActive = true;
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _startTimer();
        } else if (_isTimerActive) {
          // Time's up, move to next question
          _moveToNextQuestion();
        }
      });
    });
  }
  
  void _moveToNextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      _isTimerActive = false;
      setState(() {
        _currentQuestionIndex++;
        // Reset timer for new question
        if (widget.questions[_currentQuestionIndex].seconds > 0) {
          _secondsRemaining = widget.questions[_currentQuestionIndex].seconds;
          _startTimer();
        }
      });
    } else {
      _isTimerActive = false;
      _showResults();
    }
  }

  @override
  void dispose() {
    _isTimerActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.quiz.title)),
        body: Center(child: Text("Тест не содержит вопросов")),
      );
    }

    Question question = widget.questions[_currentQuestionIndex];
    double progress = (_currentQuestionIndex + 1) / widget.questions.length;
    List<dynamic> answers = question.answers ?? [];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 8,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Вопрос ${_currentQuestionIndex + 1} из ${widget.questions.length}",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                if (_secondsRemaining > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _secondsRemaining < 10 ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "$_secondsRemaining сек",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            
            // Question text
            Text(
              question.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            
            // Question image if available
            if (question.img.isNotEmpty)
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(question.img),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            
            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  final answer = answers[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(bottom: 8),
                    child: RadioListTile<int>(
                      title: Text(
                        answer['title'] ?? "Ответ ${index + 1}",
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
                },
              ),
            ),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _isTimerActive = false;
                      setState(() {
                        _currentQuestionIndex--;
                        // Reset timer for previous question
                        if (widget.questions[_currentQuestionIndex].seconds > 0) {
                          _secondsRemaining = widget.questions[_currentQuestionIndex].seconds;
                          _startTimer();
                        }
                      });
                    },
                    child: Text("Назад"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  )
                else
                  SizedBox(width: 10),

                // Next/Finish button
                ElevatedButton(
                  onPressed: () {
                    _isTimerActive = false;
                    if (_currentQuestionIndex < widget.questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                        // Reset timer for new question
                        if (widget.questions[_currentQuestionIndex].seconds > 0) {
                          _secondsRemaining = widget.questions[_currentQuestionIndex].seconds;
                          _startTimer();
                        }
                      });
                    } else {
                      _showResults();
                    }
                  },
                  child: Text(_currentQuestionIndex == widget.questions.length - 1 ? "Завершить" : "Далее"),
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

  void _showResults() {
    int correctAnswers = 0;
    List<Map<String, dynamic>> resultData = [];

    for (int i = 0; i < widget.questions.length; i++) {
      Question question = widget.questions[i];
      List<dynamic> answers = question.answers ?? [];
      
      int? userAnswerIndex = _answers[i];
      String userAnswerText = userAnswerIndex != null && userAnswerIndex < answers.length 
          ? answers[userAnswerIndex]['title'] ?? "Не выбрано" 
          : "Не выбрано";
      
      // Find correct answer
      int correctIndex = -1;
      String correctAnswerText = "Не найдено";
      
      for (int j = 0; j < answers.length; j++) {
        if (answers[j]['isCorrect'] == true) {
          correctIndex = j;
          correctAnswerText = answers[j]['title'] ?? "Не найдено";
          break;
        }
      }
      
      bool isCorrect = userAnswerIndex == correctIndex;
      if (isCorrect) correctAnswers++;
      
      resultData.add({
        "question": question.title,
        "userAnswer": userAnswerText,
        "correctAnswer": correctAnswerText,
        "isCorrect": isCorrect
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          questions: widget.questions,
          results: resultData,
          correctCount: correctAnswers,
          totalCount: widget.questions.length,
        ),
      ),
    );
  }
}