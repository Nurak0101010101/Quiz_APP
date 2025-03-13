import 'package:flutter/material.dart';
import 'screen/home_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Тестирование',
      theme: AppTheme.lightTheme, // 🎨 Подключаем тему
      home: HomePage(),
    );
  }
}
