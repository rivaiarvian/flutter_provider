import 'package:flutter/foundation.dart';
import 'package:provider_testing/model/person.dart';

class PersonProvider extends ChangeNotifier {
  Person _data = Person('', 0);
  Person get data => _data;

  updateName(String n) {
    _data = _data.copyWith(name: n);
    notifyListeners();
  }

  updateAge(int a) {
    _data = _data.copyWith(age: a);
    notifyListeners();
  }
}
