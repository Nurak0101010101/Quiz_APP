import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:quiz_app/screen/test_page.dart';
import '../servise/pocketbase_service.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? currentUser; // Данные пользователя

  @override
  void initState() {
    super.initState();
    // _checkAuth();
  }
Future<void> logout(BuildContext context) async {
    await pocketBaseService.clearAuth();
    print('logout');
    context.go('/login');
  }

  void _checkAuth() {
    if (!pocketBaseService.pb.authStore.isValid) {
      // Если не авторизован, переходим на страницу входа
      Future.microtask(() {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
      });
    } else {
      setState(() {
        currentUser = pocketBaseService.pb.authStore.model;
      });
    }
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
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Настройки"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("О приложении"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Выход"),
              onTap: ()=>logout(context),
            ),
          ],
        ),
      ),
      body: Center(child: Text("Здесь будут тесты")),
    
    );
  }
  
}

