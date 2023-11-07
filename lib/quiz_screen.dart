import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'models/question.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Question> questions = [
    Question(
      questionText: "What is the capital of France?",
      options: ["London", "Paris", "Berlin", "Madrid"],
      correctOption: 1,
    ),
    Question(
      questionText: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
      correctOption: 1,
    ),
    Question(
      questionText: "what is the capital of Nepal?",
      options: ["Kathmandu", "Pokhara", "Dhangadhi", "Rukum"],
      correctOption: 0,
    ),
    // Add more questions...
  ];

  void checkAnswer(int selectedOption) {
    if (selectedOption == questions[currentQuestionIndex].correctOption) {
      setState(() {
        score++;
      });
    }
    goToNextQuestion();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Show the result screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: questions.length,
            onTryAgain: () {
              setState(() {
                currentQuestionIndex = 0;
                score = 0; // Reset to 0
              });
              Navigator.pop(context); // Go back to the quiz screen
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              questions[currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: questions[currentQuestionIndex]
                  .options
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(entry.key),
                        child: Text(entry.value),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
