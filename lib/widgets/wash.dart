import 'package:flutter/material.dart';
import 'package:wash_x/controller/choicecontroller.dart';
import 'package:wash_x/custom/washbar.dart';

class CustomWash extends StatefulWidget {
  @override
  _CustomWash createState() => new _CustomWash();
}

class _CustomWash extends State<CustomWash> {

  List<String> wash = ['HAND', 'MACHINE', 'DRY CLEAN'];
  List<String> dry = ['HANG', 'MACHINE DRY', 'DRY CLEAN'];
  List<String> fold = ['HAND', 'MACHINE', 'DRY CLEAN'];
  ChoiceController _washController;
  ChoiceController _dryController;
  ChoiceController _foldController;

  @override
  void initState(){
    _washController = new ChoiceController(list: wash);
    _dryController = new ChoiceController(list: dry);
    _foldController = new ChoiceController(list: fold);
  }

  void _confirm(){

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
        new Container(
          alignment: Alignment.center,
          child: new Icon(Icons.drag_handle)),
        new Text('WASH',style: new TextStyle(fontSize: 18.0, color: Colors.blueAccent)),
        new WashBar(controller: _washController, list: wash,avatar: Icons.add,),
        new Text('DRY',style: new TextStyle(fontSize: 18.0, color: Colors.blueAccent)),
        new WashBar(controller: _dryController, list: wash,avatar: Icons.add),
        new Text('FOLD',style: new TextStyle(fontSize: 18.0, color: Colors.blueAccent)),
        new WashBar(controller: _foldController, list: wash,avatar: Icons.add),
        new Expanded(
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new ActionChip(
                    label: new Text('CANCEL'),
                    onPressed: (){
                      Navigator.pop(context);
                      },),
                  new ActionChip(
                    label: new Text('ADD'),
                    avatar: new Icon(Icons.add),
                    onPressed: (){},),
                ]
            )
        )

      ]
    ));
  }
}