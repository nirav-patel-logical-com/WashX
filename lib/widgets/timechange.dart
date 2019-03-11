import 'package:flutter/material.dart';
import 'package:wash_x/models/model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/controller/choicecontroller.dart';
import 'package:wash_x/custom/washbar.dart';
import 'package:wash_x/helpers/washfirebase.dart';

class CustomTimeChange extends StatefulWidget {
  @override
  _CustomTimeChange createState() => new _CustomTimeChange();
}

class _CustomTimeChange extends State<CustomTimeChange> {

  ChoiceController _timeController;
  ChoiceController _dayController;
  bool _ondemand = false;

  List<String> _time = ['MORNING', 'NOON', 'EVENING'];
  List<String> _dayweek = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  static const text = 'Pick Up will occur anywhere between 8AM and 12PM.\n'
      'You will receive  a more precise approximation on the '
      'the day of pickup and delivery';

  void onChanged(bool value){
    _ondemand = value;
  }

  @override
  void initState() {
    super.initState();
    _timeController = new ChoiceController(list: _time,);
    _dayController = new ChoiceController(list: _dayweek,);
  }

  void update(){
    DeliveryTimeModel a = new DeliveryTimeModel(
        weekday: _dayController.item,
        time: _timeController.item,
        ondemand: _ondemand
    );
    WashDatabase().updateDeliveryTime(a);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(
        builder: (context, child, model) {
          _dayController.item = model.delivery.weekday;
          _timeController.item = model.delivery.time;
          _ondemand = model.delivery.ondemand;
          return new Container(
              margin: new EdgeInsets.all(16.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Container(
                        alignment: Alignment.center,
                        child: new Icon(Icons.drag_handle)),
                    new Text(text,style: new TextStyle(fontSize: 16.0)),
                    new Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text('On demand',
                              style: new TextStyle(color: Colors.blueAccent, fontSize: 18.0)),
                          new Checkbox(
                              value: _ondemand,
                              onChanged: (bool value){
                                model.delivery.ondemand = value;
                                model.notifyListeners();
                                //onChanged(value);
                              }),
                        ]),
                    new WashBar(controller: _timeController, list: _time,),
                    new WashBar(controller: _dayController, list: _dayweek,),
                  ]));
        });
  }

  @override
  void dispose() {
    update();
    super.dispose();
  }
}