import 'package:flutter/material.dart';
import 'QuizzerViewModel.dart';

QuizzerViewModel quizzer = QuizzerViewModel();

class QuizzerPage extends StatefulWidget {
  const QuizzerPage({Key? key}) : super(key: key);

  @override
  State<QuizzerPage> createState() => _QuizzerPageState();
}

class _QuizzerPageState extends State<QuizzerPage> {
  List<Icon> scoreTracking = [];
  int points = 0;
  String result = '';

  void newQuestion() {
    quizzer.newQuestion();
  }

  var showTFButtons = true;
  var showPlayAgainButton = false;
  var showQuestion = true; // New variable to toggle question display

  void checkResponse(bool response) {
    if (response == quizzer.getAnswer()) {
      points += 1;
      scoreTracking.add(
        const Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scoreTracking.add(
        const Icon(
          Icons.close,
          color: Colors.red,
        ),
      );
    }
  }

  void theGameEnded() {
    if (scoreTracking.length == 14) {
      result = 'Your score: $points';
      points = 0;
      showPlayAgainButton = true;
      showTFButtons = false;
      showQuestion = false; // Hide the question at the end
    } else {
      result = '';
    }
  }

  void theGameBegin() {
    showPlayAgainButton = false;
    showTFButtons = true;
    showQuestion = true; // Show the question again when restarting
    result = '';
    scoreTracking = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  showQuestion
                      ? quizzer.getQuestion()
                      : result, // Show question only if game hasn't ended
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (showTFButtons)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        checkResponse(true);
                        newQuestion();
                        theGameEnded();
                      });
                    },
                    child: const Center(
                      child: Text(
                        'True',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (showTFButtons)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        checkResponse(false);
                        newQuestion();
                        theGameEnded();
                      });
                    },
                    child: const Center(
                      child: Text(
                        'False',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (showPlayAgainButton)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade600,
                    ),
                    onPressed: () {
                      setState(() {
                        newQuestion();
                        theGameBegin();
                      });
                    },
                    child: const Center(
                      child: Text(
                        'Play Again',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scoreTracking,
            ),
          ],
        ),
      ),
    );
  }
}

