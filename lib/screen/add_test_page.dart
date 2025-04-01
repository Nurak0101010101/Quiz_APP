import 'package:flutter/material.dart';
import '../models/test_model.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _titleController = TextEditingController();

  void _saveTest() {
    if (_titleController.text.isNotEmpty) {
      final newTest = Test(
        title: _titleController.text,
        questions: [], category: '', // Пока пустой список вопросов
      );

      Navigator.pop(context, newTest); // Возвращаем новый тест в HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Добавить тест")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Название теста"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTest,
              child: Text("Сохранить"),
            ),
          ],
        ),
      ),
    );
  }
}
