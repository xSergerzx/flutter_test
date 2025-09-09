import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(PlaywrightTest());
}

class PlaywrightTest extends StatefulWidget {
  @override
  State<PlaywrightTest> createState() => PlaywrightTestState();
}

class TestItem {
  final String question;
  final List<String> options;
  final int correctIndex;

  TestItem({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class PlaywrightTestState extends State<PlaywrightTest> {
  List<TestItem> tests = [];        // Сюда будут загружаться тесты из JSON
  int currentTestIndex = 0;         // Индекс текущего теста
  String? resultMessage;            // Сообщение "правильно / неправильно"

  // ----------------------------
  // Метод для загрузки тестов из JSON
  Future<void> loadTests() async {
    final data = await rootBundle.loadString('assets/tests.json');
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      tests = jsonResult.map((json) => TestItem(
        question: json['question'],
        options: List<String>.from(json['options']),
        correctIndex: json['correctIndex'],
      )).toList();
    });
  }
  // ----------------------------

  @override
  void initState() {
    super.initState();
    loadTests(); // загружаем тесты при старте
  }

  // Проверка ответа
  void checkAnswer(int selectedIndex) {
    setState(() {
      if (selectedIndex == currentTest.correctIndex) {
        resultMessage = '✅ Правильно!';
      } else {
        resultMessage = '❌ Неправильно!';
      }
    });
  }

  // Переход к следующему тесту
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

  // Геттер текущего теста
  TestItem get currentTest => tests[currentTestIndex];

  @override
  Widget build(BuildContext context) {
    // Пока тесты не загрузились
    if (tests.isEmpty) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Playwright Practice')),
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Playwright Practice')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Вопрос
              Text(
                currentTest.question,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Кнопки с вариантами
              for (int i = 0; i < currentTest.options.length; i++)
                ElevatedButton(
                  onPressed: () => checkAnswer(i),
                  child: Text(currentTest.options[i]),
                ),

              const SizedBox(height: 20),

              // Результат и кнопка "Следующий тест"
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
      ),
    );
  }
}