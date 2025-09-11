import 'package:flutter/material.dart';
import 'loader.dart';
import 'level_selection.dart';

void main() {
  runApp(MaterialApp(
    home: LevelSelectionScreen(),
  ));
}

class PlaywrightTest extends StatefulWidget {
  final int level;

  PlaywrightTest({required this.level});

  @override
  State<PlaywrightTest> createState() => PlaywrightTestState();
}

class PlaywrightTestState extends State<PlaywrightTest> {
  List<TestItem> tests = [];
  int currentTestIndex = 0;
  String? resultMessage;

  @override
  void initState() {
    super.initState();
    loadLevel(widget.level).then((loadedTests) {
      setState(() {
        tests = loadedTests;
      });
    });
  }
  

  void checkAnswer(int selectedIndex) {
    setState(() {
      if (selectedIndex == currentTest.correctIndex) {
        resultMessage = '✅ Правильно!';
      } else {
        resultMessage = '❌ Неправильно!';
      }
    });
  }

  void nextTest() {
    setState(() {
      if (currentTestIndex < tests.length - 1) {
        currentTestIndex++;
        resultMessage = null;
      } else {
        resultMessage = '🎉 Все тесты пройдены!';
      }
    });
  }

  TestItem get currentTest => tests[currentTestIndex];

  @override
  Widget build(BuildContext context) {
    if (tests.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Playwright Practice')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Playwright Practice')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentTest.question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            for (int i = 0; i < currentTest.options.length; i++)
              ElevatedButton(
                onPressed: () => checkAnswer(i),
                child: Text(currentTest.options[i]),
              ),

            const SizedBox(height: 20),

            if (resultMessage != null)
              Column(
                children: [
                  Text(
                    resultMessage!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: nextTest,
                    child: Text('Следующий тест'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
