import 'package:flutter/material.dart';
import 'package:quiz_app/router.dart';
import 'screen/home_page.dart';
import 'servise/pocketbase_service.dart';
import 'theme/app_theme.dart';

void main() async{
   await pocketBaseService.initAuth();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Тестирование',
      theme: AppTheme.lightTheme, // 🎨 Подключаем тему
      routerConfig: router,
    );
  }
}
