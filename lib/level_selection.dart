import 'package:flutter/material.dart';
import 'main.dart';

class LevelSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Выбор уровня')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Уровень 1'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaywrightTest(level: 1),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('Уровень 2'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaywrightTest(level: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
