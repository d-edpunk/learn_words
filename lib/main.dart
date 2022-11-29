import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/home_screen.dart';
import 'src/words.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Words words = Words();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => words,
        child: const MaterialApp(home: HomeScreen()));
  }
}
