import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider_testing/model/game.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getLive() async {
    String url = 'https://www.freetogame.com/api/games';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List list = jsonDecode(response.body);
        List<Game> games = list.map((e) => Game.fromJson(Map.from(e))).toList();
        return games;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
