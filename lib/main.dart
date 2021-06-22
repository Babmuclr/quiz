import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quizbank.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  Icon createIcon (bool isCollect) {
    var icon;
    if (isCollect) {
      icon = Icon(
        Icons.check,
        color: Colors.green,
      );
    }else {
      icon = Icon(
        Icons.close,
        color: Colors.red,
      );
    }
    return icon;
  }

  void countCollects(bool isCollect){
    if (isCollect) {
      numCollectAnswer++;
    }
  }

  List<Icon> scoreKeeper = [];
  Quizbank quizbank = Quizbank();
  int numCollectAnswer = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbank.getQuizText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper.add(createIcon(true == quizbank.getQuizAnswer()));
                  countCollects(true == quizbank.getQuizAnswer());
                  if (quizbank.isFinished()){
                    Alert(
                      context: context,
                      title: "Finished",
                      desc: "You Get $numCollectAnswer.",
                      buttons: [
                        DialogButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              quizbank.resetQuestionNum();
                              scoreKeeper = [];
                              numCollectAnswer=0;
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                  }else{
                    quizbank.nextQuestion();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  scoreKeeper.add(createIcon(false == quizbank.getQuizAnswer()),);
                  countCollects(false == quizbank.getQuizAnswer());
                  if (quizbank.isFinished()){
                    Alert(
                      context: context,
                      title: "Finished",
                      desc: "You Get $numCollectAnswer.",
                      buttons: [
                        DialogButton(
                          child: Text('Reset'),
                          onPressed: () {
                            setState(() {
                              quizbank.resetQuestionNum();
                              scoreKeeper = [];
                              numCollectAnswer=0;
                            });
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ).show();
                  }else{
                    quizbank.nextQuestion();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
