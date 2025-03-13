import 'package:flutter/material.dart';
import '../models/test_model.dart';
import '../models/question_model.dart';

class CreateTestPage extends StatefulWidget {
  @override
  _CreateTestPageState createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage> {
  final _titleController = TextEditingController();
  String _selectedCategory = "Кругозор"; // Категория по умолчанию
  List<Question> _questions = [];

  void _addQuestion() {
    setState(() {
      _questions.add(Question(text: "", answers: ["", "", "", ""], correctAnswerIndex: 0));
    });
  }

  void _saveTest() {
    if (_titleController.text.isEmpty || _questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Заполните все поля и добавьте хотя бы один вопрос!")),
      );
      return;
    }

    final newTest = Test(
      title: _titleController.text,
      category: _selectedCategory,
      questions: _questions,
    );

    Navigator.pop(context, newTest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Создать тест")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Название теста"),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: ["Математика", "Биология", "Химия", "География", "Физика", "Кругозор"]
                  .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                  .toList(),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text("Добавить вопрос"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(index);
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveTest,
              child: Text("Сохранить тест"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Вопрос"),
              onChanged: (value) {
                _questions[index] = Question(
                  text: value,
                  answers: _questions[index].answers,
                  correctAnswerIndex: _questions[index].correctAnswerIndex,
                );
              },
            ),
            SizedBox(height: 5),
            Column(
              children: List.generate(4, (i) {
                return TextField(
                  decoration: InputDecoration(labelText: "Ответ ${i + 1}"),
                  onChanged: (value) {
                    List<String> updatedAnswers = List.from(_questions[index].answers);
                    updatedAnswers[i] = value;
                    _questions[index] = Question(
                      text: _questions[index].text,
                      answers: updatedAnswers,
                      correctAnswerIndex: _questions[index].correctAnswerIndex,
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Правильный ответ:"),
                DropdownButton<int>(
                  value: _questions[index].correctAnswerIndex,
                  onChanged: (value) {
                    setState(() {
                      _questions[index] = Question(
                        text: _questions[index].text,
                        answers: _questions[index].answers,
                        correctAnswerIndex: value!,
                      );
                    });
                  },
                  items: List.generate(
                    4,
                    (i) => DropdownMenuItem(value: i, child: Text("Ответ ${i + 1}")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
