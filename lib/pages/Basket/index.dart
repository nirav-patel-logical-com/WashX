import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/widgets/wash_bottom_sheet.dart';
import 'package:wash_x/widgets/startwashbutton.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPage createState() => _BasketPage();
}

class _BasketPage extends State<BasketPage>
    with AutomaticKeepAliveClientMixin<BasketPage> {
  BasketModel basketModel;
  StreamSubscription _subsBasket;

  @override
  void initState() {
    super.initState();
    basketModel = new BasketModel();
    WashDatabase()
        .getBasketModel(_updateBasket)
        .then((StreamSubscription s) => _subsBasket = s);
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BasketModel>(
      model: basketModel,
      child: ScopedModelDescendant<BasketModel>(
        builder: (context, child, model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /*    new Expanded(
                child:  ListView.builder(
              cacheExtent: 0.0,
              itemCount: model.items.length,
              itemBuilder: (context, int index) {
                BasketItem item = model.items[index];
                return new WashTileActive(item: item);
              },
            )),
            */
              Expanded(
                child: Icon(MyFlutterApp.trash, size: 175.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: StartWashButton(onPressed: () {
                  _showBottomSheet();
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  _updateBasket(BasketModel value) {
    setState(() {
      basketModel = value;
    });
  }

  _showBottomSheet() {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3 * 2,
            child: WashBottomSheet(
              items: clothes,
            ),
          );
        });
  }
}
