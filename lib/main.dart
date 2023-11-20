import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QUIZ APP-CODE CASA',
      theme: ThemeData(
        primaryColor: Colors.green,
        
        scaffoldBackgroundColor: Colors.green[100],
        
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who is the President of India?',
      'answers': ['Narendra Modi', 'Amit Shah', 'Ram Nath Kovind', 'Rahul Gandhi'],
      'correctIndex': 2,
    },
    {
      'question': 'Which party won the most seats in the last general election?',
      'answers': ['BJP', 'Congress', 'AAP', 'CPI(M)'],
      'correctIndex': 0,
    },
    {
      'question': 'Who is the Prime Minister of India?',
      'answers': ['Amit Shah', 'Sonia Gandhi', 'Narendra Modi', 'Manmohan Singh'],
      'correctIndex': 2,
    },
    {
      'question': 'Which state has the highest number of Lok Sabha seats?',
      'answers': ['Maharashtra', 'Uttar Pradesh', 'West Bengal', 'Karnataka'],
      'correctIndex': 1,
    },
    {
      'question': 'In which year was the first general election held in India?',
      'answers': ['1947', '1950', '1952', '1960'],
      'correctIndex': 2,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    int correctIndex = _questions[_questionIndex]['correctIndex'];
    if (selectedIndex == correctIndex) {
      setState(() {
        _score++;
      });
    }
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: $_score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _questionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('QUIZ APP-CODE CASA',style: TextStyle(fontSize: 25),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _questions[_questionIndex]['question'],
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: (_questions[_questionIndex]['answers'] as List<String>).map(
                (answer) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 13.0),
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      onPressed: () {
                        _answerQuestion(
                            (_questions[_questionIndex]['answers'] as List<String>).indexOf(answer));
                      },
                      child: Text(answer),
                    ),
                  );
                },
              ).toList(),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Question ${_questionIndex + 1}/${_questions.length}',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              onPressed: () {
                _showResultDialog();
              },
              child: Text('End Quiz',style: TextStyle(fontSize: 25),),
            ),
          ],
        ),
      ),
    );
  }
}
