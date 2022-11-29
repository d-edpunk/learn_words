import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';

class Words with ChangeNotifier {
  List<dynamic> words = [];
  bool _loaded = true;
  bool _back = false;
  int _nextWord = 0;

  Words() {
    loadJson();
  }

  bool get loaded => _loaded;
  set loaded(bool state) {
    _loaded = state;
    notifyListeners();
  }

  Future<void> loadJson() async {
    var json = jsonDecode(await rootBundle.loadString('assets/words.json'));
    words.addAll(json);
    loaded = true;
  }

  void startNewRandom() {
    words.shuffle();
    _nextWord = 0;
  }

  Map<String, dynamic> getRandomWord() {
    var newValue = _nextWord + (_back ? -1 : 1);
    if (newValue == -1) {
      newValue = words.length - 1;
    } else if (newValue == words.length) {
      newValue = 0;
    }
    _nextWord = newValue;
    _back = false;
    return words[_nextWord];
  }

  void goBackByRandom() => _back = true;
}
