import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class CustomListTile extends StatelessWidget{
  CustomListTile({this.item});
  final BasketItem item;

  @override
  Widget build(BuildContext context) {
    //print('context.size=${context.size}');
    return new Card(
      elevation: 5.0,
      margin: new EdgeInsets.all(5.0),
      child: new Stack(children: <Widget>[
        new Container(
            height: 72.0,
            width: item.current,
              decoration:  new BoxDecoration(
              color: new Color.fromARGB(100,176,218,255),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(5.0)
              )),
        new ListTile(
            leading: new Icon(icons[item.clothe]),
            title: new Text(item.clothe),
            subtitle: new Text('\$${item.price}'),
            trailing: new Icon(MyFlutterApp.dot_3)
        )
      ]),
    );
  }
}