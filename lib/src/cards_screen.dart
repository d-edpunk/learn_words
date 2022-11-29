import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'words.dart';
import 'home_screen.dart' show MenuButton;

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> word = context.watch<Words>().getRandomWord();

    return Card(upperChildren: [
      WordText(word['original'])
    ], lowerChildren: [
      WordText(word['translation']),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: MenuButton(
                name: 'Next',
                onPressed: () {
                  setState(() {});
                })),
        Container(
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: MenuButton(
                name: 'Back',
                onPressed: () {
                  context.read<Words>().goBackByRandom();
                  setState(() {});
                }))
      ])
    ]);
  }
}

class WordText extends StatelessWidget {
  final String text;

  const WordText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold));
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
