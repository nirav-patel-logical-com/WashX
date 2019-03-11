import 'package:flutter/widgets.dart';

class ChoiceController extends ChangeNotifier{
  ChoiceController({@required this.list});
  List<String> list;

  void _changeIndex(int value) {
    //assert(value != null);
   // assert(value >= 0 && (value < list.length || list.length == 0));
    if (value == _index || list.length < 2)
      return;
    _index = value;
    notifyListeners();
  }

  int get index => _index;

  int _index;

  set index(int value) {
    _changeIndex(value);
  }

  String get item {
    return list[_index];
  }

  set item(String value){
    _changeIndex(list.indexOf(value));
  }

}