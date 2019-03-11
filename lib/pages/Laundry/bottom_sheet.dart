import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/widgets/washtile.dart';

class WashLaundry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          alignment: Alignment.center, child: new Icon(Icons.drag_handle)),
      Expanded(
          child: new ListView.builder(
              itemCount: clothes.length,
              itemBuilder: (BuildContext context, int index) {
                BasketItem item = clothes[index];
                print(item.toJson());
                return new WashTile(
                  basketItem: item,
                );
              }))
    ]);
  }
}
