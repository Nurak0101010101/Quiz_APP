import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Профиль")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
               backgroundImage: AssetImage("assets/avatar.png"), // Заглушка для аватара
              ),
            ),
            SizedBox(height: 20),
            Text("Имя пользователя:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("User123", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Email:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("user@example.com", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Center(
            ),
          ],
        ),
      ),
    );
  }
}
