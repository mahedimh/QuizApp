import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'What is the capital of Bangladesh?',
      'options': ['Dhaka', 'Chittagong', 'Rajshahi', 'Khulna'],
      'correctAnswer': 'Dhaka',
    },
    {
      'question': 'Which river is known as the lifeline of Bangladesh?',
      'options': ['Jamuna', 'Padma', 'Meghna', 'Ganges'],
      'correctAnswer': 'Padma',
    },
    {
      'question': 'What is the official language of Bangladesh?',
      'options': ['Bengali', 'English', 'Hindi', 'Urdu'],
      'correctAnswer': 'Bengali',
    },
    {
      'question': 'Which political leader led Bangladesh to independence in 1971?',
      'options': ['Sheikh Mujibur Rahman', 'Ziaur Rahman', 'Hasina Wazed', 'Khaleda Zia'],
      'correctAnswer': 'Sheikh Mujibur Rahman',
    },
    {
      'question': 'What is 2 + 2?',
      'options': ['1', '2', '3', '4'],
      'correctAnswer': '4',
    },
    {
      'question': 'What is the capital of France?',
      'options': ['London', 'Berlin', 'Paris', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    // Add more questions as needed
  ];

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer =
    _quizData[_currentQuestionIndex]['correctAnswer'];

    setState(() {
      if (selectedAnswer == correctAnswer) {
        _score++;
      }

      if (_currentQuestionIndex < _quizData.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Complete'),
          content: Text('Your score is $_score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Restart Quiz'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestionData =
    _quizData[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestionData['question'],
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            ...List.generate(currentQuestionData['options'].length, (index) {
              String option = currentQuestionData['options'][index];
              return ElevatedButton(
                onPressed: () {
                  _checkAnswer(option);
                },
                child: Text(option),
              );
            }),
          ],
        ),
      ),
    );
  }
}