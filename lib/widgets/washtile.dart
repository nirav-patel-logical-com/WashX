import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';

class WashTile extends StatelessWidget {
  final BasketItem basketItem;

  WashTile({this.basketItem});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        leading: Icon(icons[basketItem.clothe]),
        title: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(basketItem.clothe),
              new Text(basketItem.price.toString())
            ]),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {
                //TODO
              },
              icon: Icon(Icons.create),
              iconSize: 22.0,
              color: Colors.blueAccent,
              disabledColor: Colors.blueAccent,
            ),
            ActionChip(
                backgroundColor: Colors.blueAccent,
                label:
                    new Text('WASH', style: new TextStyle(color: Colors.white)),
                onPressed: () {
                  WashDatabase().addItemBasket(basketItem);
                })
          ],
        ));
  }
}
