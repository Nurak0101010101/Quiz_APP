import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Настройки")),
      body: Center(
        child: Text("Страница настроек", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
