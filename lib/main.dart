import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class Question {
  String question = "";
  List<String> awnsers = [];

  Question({required this.question, required this.awnsers});
}

class Awnser {
  String question;
  String awnser;

  Awnser({required this.question, required this.awnser});
}

class _MyAppState extends State<MyApp> {
  // preguntas:
  final preguntas = [
    Question(
        question: "Cual es tu color favorito?",
        awnsers: ["rojo", "amarillo", "verde", "azul"]),
    Question(
        question: "Cual es tu animal favorito",
        awnsers: ["Gato", "Perro", "Delfin", "Pajaro"]),
    Question(
        question: "Cual es tu lugar favorito para vacacionar",
        awnsers: ["Montaña", "Rio", "playa"])
  ];

  // estado
  int questionIndex = 0;
  List<Awnser> awnsers = [];
  void handleNextQuestion(question, awnser, index) {
    setState(() {
      questionIndex += 1;
      awnsers = [...awnsers, Awnser(question: question, awnser: awnser)];
    });
  }

  handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(100, 100, 100, .8),
        appBar: AppBar(
          title: const Text('Test de personalidad'),
        ),
        body: ListView(
          children: <Widget>[
            LinearProgressIndicator(
              value: questionIndex / preguntas.length,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: questionIndex >= preguntas.length - 1
                    ? AwnsersBody(awnsers: awnsers)
                    : QuestionBody(
                        question: preguntas[questionIndex],
                        handleNextQuestion: handleNextQuestion,
                      )),
          ],
        ),
      ),
    );
  }
}

class AwnsersBody extends StatelessWidget {
  const AwnsersBody({
    required List<Awnser> awnsers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("awnsers");
  }
}

// ignore: must_be_immutable
class QuestionBody extends StatefulWidget {
  Question question;
  Function handleNextQuestion;

  QuestionBody({
    required this.question,
    required this.handleNextQuestion,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionBody> createState() => _QuestionBodyState();
}

class _QuestionBodyState extends State<QuestionBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Text(
            "¿" +
                widget.question.question.replaceAll(RegExp(r"[?¿]"), "") +
                "?",
            style: const TextStyle(color: Colors.white70, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < widget.question.awnsers.length; i++)
              ElevatedButton(
                  onPressed: () => widget.handleNextQuestion(
                      widget.question.question, widget.question.awnsers[i], i),
                  child: Text(widget.question.awnsers[i])),
          ],
        )
      ],
    );
  }
}
