import 'package:flutter/material.dart';
import 'package:provider_testing/model/animals2.dart';
import 'package:uuid/uuid.dart';

class Animals2Provider extends ChangeNotifier {
  final List<Animals2> _animals = [];
  List<Animals2> get animals => _animals;

  add(String name, String species) {
    Animals2 newAnimal = Animals2(
      id: Uuid().v4(),
      name: name,
      species: species,
    );
    _animals.add(newAnimal);
    notifyListeners();
  }

  remove(Animals2 animal) {
    _animals.removeWhere((element) => element.id == animal.id);
    notifyListeners();
  }

  update(String oldId, String name, String species) {
    int index = _animals.indexWhere((e) => e.id == oldId);
    _animals[index] = Animals2(
      id: oldId,
      name: name,
      species: species,
    );
    notifyListeners();
  }
}
