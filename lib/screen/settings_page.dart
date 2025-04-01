import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Флаг для тёмной темы

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Настройки")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: Text("Тёмная тема"),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                // Здесь можно добавить изменение темы в приложении
              });
            },
          ),
          ListTile(
            title: Text("Сбросить настройки"),
            trailing: Icon(Icons.restore),
            onTap: () {
              // Логика сброса настроек
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Настройки сброшены")),
              );
            },
          ),
        ],
      ),
    );
  }
}
