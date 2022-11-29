import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'words.dart';
import 'cards_screen.dart';
import 'exam_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<Words>().startNewRandom();
    return !context.watch<Words>().loaded
        ? const Scaffold(
            backgroundColor: Colors.yellow,
            body: Center(child: CircularProgressIndicator(color: Colors.black)))
        : Scaffold(
            backgroundColor: Colors.yellow,
            body: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: MenuButton(
                          name: 'Random Words',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CardsScreen()));
                          })),
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: MenuButton(
                          name: 'Exam',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ExamScreen()));
                          })),
                ])));
  }
}

class MenuButton extends StatelessWidget {
  final String name;
  final void Function() onPressed;

  const MenuButton({required this.name, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
          onPressed: onPressed,
          child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
        ));
  }
}
