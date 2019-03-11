import 'package:flutter/material.dart';
import 'package:wash_x/controller/choicecontroller.dart';



class WashBar extends StatefulWidget {
  const WashBar({
    this.key,
    this.controller,
    this.list,
    this.avatar
  });

  final Key key;
  final ChoiceController controller;
  final List<String> list;
  final IconData avatar;

  @override
  _WashBar createState() => new _WashBar();
}

class _WashBar extends State<WashBar> {
  int _value = -1;

  List<String> _list;
  ChoiceController _controller;
  IconData _avatar;

  String get value => _list[_value];

  @override
  void initState(){
    super.initState();
    _list = widget.list;
    _controller = widget.controller;
    _value = _controller.index;
    _controller.addListener((){
      setState(() {
        _value = _controller.index;
      });
    });
  }

  _updateIndex(int value){
    _controller.index = value;
  }

  @override
  Widget build(BuildContext context) {
    _avatar = widget.avatar;

    return new Container(
      decoration: new BoxDecoration(
        border: new Border.all(color: Colors.black12),
        borderRadius: new BorderRadius.all(const Radius.circular(16.0))),
      margin: new EdgeInsets.only(top: 16.0, bottom: 16.0),
      alignment: Alignment.center,
      child:new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: new List<Widget>.generate(_list.length,(int index) {
          return new ChoiceChip(
            avatar: _avatar != null ? new Icon(_avatar,size: 18.0, color: _value == index ?
              Colors.white:Colors.blueAccent):null,
            selectedColor: Colors.blueAccent,
            backgroundColor: Colors.white10,
            label: new Text(_list[index]),
            labelStyle:  new TextStyle(color: _value == index ?
              Colors.white:Colors.blueAccent),
            selected: _controller.index == index,
            onSelected: (bool selected) {
              _updateIndex(index);
            },
          );
        }),
      )
    );
  }
}