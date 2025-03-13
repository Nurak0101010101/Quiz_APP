import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("О приложении")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Quiz App", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Версия: 1.0.0", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Приложение для тестирования знаний", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Разработчик: Твой ник или имя", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
