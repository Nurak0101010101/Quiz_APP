import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screen/test_page.dart';
import 'package:quiz_app/servise/pocketbase_service.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'create_test_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Quiz>> future;
  
  Future<List<Quiz>> getQuizes() async {
    final records = await pocketBaseService.pb.collection('quizapp_quiz').getFullList();
    return records.map((record) => Quiz.fromJson(record.toJson())).toList();
  }

  @override
  void initState() {
    future = getQuizes();
    super.initState();
  }

  Map<String, dynamic>? currentUser;

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
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future, 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No Quizes yet"));
          }
          
          var quizes = snapshot.data!;
          return ListView.builder(
            itemCount: quizes.length,
            itemBuilder: (context, index) {
              final quiz = quizes[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(quiz.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(quiz.subtitle),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Chip(
                            label: Text(quiz.category),
                            backgroundColor: Colors.blue.shade100,
                          ),
                          SizedBox(width: 8),
                          Chip(
                            label: Text(quiz.difficulty),
                            backgroundColor: _getDifficultyColor(quiz.difficulty),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => _openQuiz(context, quiz),
                ),
              );
            }
          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTestPage()),
          );
          // Refresh quizzes after returning from create page
          setState(() {
            future = getQuizes();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
  
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
      case 'легкий':
        return Colors.green.shade100;
      case 'medium':
      case 'средний':
        return Colors.orange.shade100;
      case 'hard':
      case 'сложный':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade100;
    }
  }
  
  void _openQuiz(BuildContext context, Quiz quiz) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    
    try {
      // Fetch questions for this quiz
      final questionsResponse = await pocketBaseService.pb.collection('quizapp_question')
        .getFullList(filter: 'quiz="${quiz.id}"');
      
      if (questionsResponse.isEmpty) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Этот тест не содержит вопросов'))
        );
        return;
      }
      
      // Convert to Question objects
      final questions = questionsResponse.map((record) => 
        Question.fromJson(record.toJson())).toList();
      
      // For each question, fetch its answers
      for (var question in questions) {
        final answersResponse = await pocketBaseService.pb.collection('quizapp_answer')
          .getFullList(filter: 'question="${question.id}"');
        
        final answers = answersResponse.map((record) => 
          record.toJson()).toList();
        
        // We'll pass the answers separately to the test page
        question.answers = answers;
      }
      
      // Close loading dialog
      Navigator.pop(context);
      
      // Navigate to test page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestPage(quiz: quiz, questions: questions),
        ),
      );
    } catch (e) {
      // Close loading dialog
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки теста: $e'))
      );
    }
  }
}