import 'package:flutter/material.dart';

class StateStore extends ChangeNotifier {
  var name = 'john park';

  changeName(){
    name = 'no park';
    notifyListeners();
  }
}