import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// -------------------- OptionItem --------------------
class OptionItem {
  final String text;
  final String explanation;

  OptionItem({
    required this.text,
    required this.explanation,
  });

  factory OptionItem.fromJson(Map<String, dynamic> json) {
    return OptionItem(
      text: json['text'],
      explanation: json['explanation'],
    );
  }
}

// -------------------- TestItem --------------------
class TestItem {
  final String question;
  final List<OptionItem> options;
  final int correctIndex;
  final String level;

  TestItem({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.level,
  });

  factory TestItem.fromJson(Map<String, dynamic> json) {
    return TestItem(
      question: json['question'],
      options: (json['options'] as List)
          .map((item) => OptionItem.fromJson(item))
          .toList(),
      correctIndex: json['correctIndex'],
      level: json['level'],
    );
  }
}

// -------------------- Функция загрузки --------------------
Future<List<TestItem>> loadLevel(int level) async {
  final String path = 'assets/levels/level$level.json';
  final String jsonString = await rootBundle.loadString(path);
  final List<dynamic> jsonData = jsonDecode(jsonString);

  return jsonData.map((item) => TestItem.fromJson(item)).toList();
}
