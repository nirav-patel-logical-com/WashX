import 'package:flutter/material.dart';
import 'package:wash_x/widgets/carechange.dart';
import 'package:wash_x/widgets/startwashbutton.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'dart:math' as math;
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/widgets/washtileactive.dart';

class LaundryPage extends StatefulWidget {
  @override
  _LaundryPage createState() => _LaundryPage();
}

class _LaundryPage extends State<LaundryPage>
    with AutomaticKeepAliveClientMixin<LaundryPage> {
  final math.Random _rng = new math.Random();

  //List<BasketItem> basket = [];

  _addItem(Clothe item) {}

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<WashModel>(builder: (context, child, model) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /*  new Expanded(
                    child: new ListView.builder(
                        cacheExtent: 0.0,
                        itemCount: model.items.length,
                        itemBuilder: (context, int index) {
                          BasketItem item = model.items[index];
                          return new WashTileActive(item: item);
                        }
                    )
                ),
                */
          Expanded(
            child: new Icon(
              MyFlutterApp.local_laundry_service,
              size: 150.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: StartWashButton(onPressed: _showBottomSheet),
          ),
        ],
      );
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new CareChange();
        });
  }

  @override
  bool get wantKeepAlive => true;
}
