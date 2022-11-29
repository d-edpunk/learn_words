import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'words.dart';
import 'home_screen.dart' show MenuButton;
import 'cards_screen.dart' show WordText;

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  String state = 'input';
  Map<String, dynamic>? word;
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    word ??= context.watch<Words>().getRandomWord();

    return Card(upperChildren: [
      WordText(word!['original'])
    ], lowerChildren: [
      state == 'input'
          ? TextField(
              decoration: InputDecoration(
                  hintText: 'Translation',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.brown, width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.brown, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.brown, width: 2))),
              onChanged: (input) {
                _answer = input;
              })
          : AnswerText(word!['translation'],
              correct: _answer == word!['translation']),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: MenuButton(
                name: state == 'input' ? 'Check' : 'Next',
                onPressed: () {
                  setState(() {
                    if (state == 'input') {
                      state = 'check';
                    } else {
                      _answer = '';
                      word = null;
                      state = 'input';
                    }
                  });
                })),
      ])
    ]);
  }
}

class AnswerText extends StatelessWidget {
  final String text;
  final bool correct;

  const AnswerText(this.text, {required this.correct, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: correct ? Colors.green : Colors.red));
  }
}

class Card extends StatelessWidget {
  final List<Widget> upperChildren;
  final List<Widget> lowerChildren;

  const Card(
      {required this.upperChildren, required this.lowerChildren, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
            title: const Text('Random Words'), backgroundColor: Colors.black),
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent[100] ?? Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  child: Center(
                      child: Column(children: [
                    Column(children: upperChildren),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 5),
                    Column(children: lowerChildren)
                  ])))
            ])));
  }
}
