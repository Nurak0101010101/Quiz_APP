import 'package:flutter/material.dart';
import '../models/test_model.dart';
import '../screen/test_page.dart';


class TestCard extends StatelessWidget {
  final Test test;

  TestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(test.title),
        subtitle: Text(test.category),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestPage(test: test)),
          );
        },
      ),
    );
  }
}
