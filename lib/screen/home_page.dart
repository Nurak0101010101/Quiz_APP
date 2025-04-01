import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/servise/pocketbase_service.dart';
import 'test_page.dart';
import '../models/test_model.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'create_test_page.dart'; // Изменяем на правильный импорт

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Quiz>>future;
  
  Future<List<Quiz>> getQuizes()async{
    final records = await pocketBaseService.pb.collection('quizapp_quiz').getFullList();
    return records.map((record)=>Quiz.fromJson(record.toJson())).toList();
  }

  @override
 initState(){
  future = getQuizes();
  super.initState();
 }

  Map<String, dynamic>? currentUser;

  // Список тестов
  final List<Test> tests = [
    Test(
      title: "Математика",
      questions: List.generate(
        10,
        (index) => Question(
          text: "Вопрос ${index + 1} по математике",
          answers: ["Ответ 1", "Ответ 2", "Ответ 3", "Ответ 4"],
          correctAnswerIndex: 1,
        ),
      ), category: '',
    ),
    Test(
      title: "Биология",
      questions: List.generate(
        10,
        (index) => Question(
          text: "Вопрос ${index + 1} по биологии",
          answers: ["Ответ 1", "Ответ 2", "Ответ 3", "Ответ 4"],
          correctAnswerIndex: 2,
        ),
      ), category: '',
    ),
  ];

  Future<void> logout(BuildContext context) async {
    await pocketBaseService.clearAuth();
    print('logout');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Тесты")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 30, backgroundImage: AssetImage("assets/avatar.png")),
                  SizedBox(height: 10),
                  Text("Имя: ${currentUser?['username'] ?? 'Гость'}", style: TextStyle(color: Colors.white)),
                  Text("Email: ${currentUser?['email'] ?? 'Нет данных'}", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Профиль"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage())),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Настройки"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage())),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("О приложении"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage())),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Выход"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage())),
            ),
          ],
        ),
      ),
      body: FutureBuilder(future: future, builder: (context,snapshot){
       if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
       }
       else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}")
        );
        } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No Quizes yet"),);
        }
        var quizes = snapshot.data!;
        return ListView.builder(itemCount: quizes.length,itemBuilder: (context,index){
          final quiz = quizes[index];
          return ListTile(title: Text(quiz.title),
          subtitle: Text(quiz.category),
          trailing: Icon(Icons.forward),
          onTap: () {
            
          },
          );
        });
      }),

      // **ДОБАВЛЯЕМ КНОПКУ**
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTest = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTestPage()), // Исправляем на правильный класс
          );

          if (newTest != null) {
            setState(() {
              tests.add(newTest); // Добавляем тест в список
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red, // Цвет кнопки
      ),
    );
  }
}
