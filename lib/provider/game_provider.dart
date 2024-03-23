import 'package:flutter/material.dart';
import 'package:provider_testing/model/game.dart';
import 'package:provider_testing/source/game_source.dart';

enum GameStatus {
  init,
  loading,
  loaded,
  failure,
}

class GameProvider extends ChangeNotifier {
  String genre = 'Shooter';

  setGenre(String n) {
    genre = n;
    notifyListeners();
  }

  GameStatus status = GameStatus.init;
  List<Game> _games = [];
  List<Game> get games => _games;

  fetchLiveGames() async {
    status = GameStatus.loading;
    notifyListeners();

    final list = await GameSource.getLive();
    if (list == null) {
      await Future.delayed(Duration(seconds: 2));
      status = GameStatus.failure;
      notifyListeners();
      return;
    }
    _games = list!;
    status = GameStatus.loaded;
    notifyListeners();
  }

  setIsSaved(Game gameSelected, bool isSaved) {
    int index = games.indexWhere((e) => e.id == gameSelected.id);
    if (index < 0) return;

    List<Game> newGames = games;
    newGames[index] = gameSelected.copyWith(isSaved: isSaved);
    _games = newGames;
    notifyListeners();
  }
}
