import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class WashTileActive extends StatefulWidget{
  WashTileActive({this.item});
  final BasketItem item;

  @override
  _WashTileActive createState() => _WashTileActive();
}

class _WashTileActive extends State<WashTileActive>{

  @override
  Widget build(BuildContext context) {
    //print('context.size=${context.size}');
    return new Card(
      elevation: 5.0,
      margin: new EdgeInsets.all(5.0),
      child: Column(children: <Widget>[
        new ListTile(
            leading: new Icon(icons[widget.item.clothe]),
            title: new Text(widget.item.clothe),
            subtitle: new Text('\$${widget.item.price}'),
            trailing: new Icon(MyFlutterApp.dot_3)
        ),
        new LinearProgressIndicator(
          value: 0.25,
          backgroundColor: Colors.white,)
      ]),
    );
  }
}