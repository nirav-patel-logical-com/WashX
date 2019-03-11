import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/widgets/startwashbutton.dart';
import 'package:wash_x/widgets/washNew.dart';
import 'package:wash_x/widgets/washtileactive.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPage createState() => _BasketPage();
}


class _BasketPage extends State<BasketPage>
    with AutomaticKeepAliveClientMixin<BasketPage> {

  BasketModel basketModel;
  StreamSubscription _subsBasket;

  _updateBasket(BasketModel value){
    setState(() {
      basketModel = value;
    });
  }


  @override
  void initState() {
    super.initState();
    basketModel = new BasketModel();
    WashDatabase().getBasketModel( _updateBasket)
        .then((StreamSubscription s) => _subsBasket = s);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BasketModel>(
        model: basketModel,
        child: ScopedModelDescendant<BasketModel>(
            builder: (context, child, model) {
              return Stack(
                  alignment: FractionalOffset.center,
                  children: <Widget>[
                    new Column(
                        children: <Widget>[
                          Expanded(
                              child: new ListView.builder(
                                  cacheExtent: 0.0,
                                  itemCount: model.items.length,
                                  itemBuilder: (context, int index) {
                                    BasketItem item = model.items[index];
                                    return new WashTileActive(item: item);
                                  }
                              )
                          ),
                          Container(
                            child: Icon(MyFlutterApp.trash,size: 175.0),
                            //padding: new EdgeInsets.only(top:100.0),
                          ),
                          StartWashButton(onPressed: (){
                            _showBottomSheet();
                          })
                        ]),
                  ]);
            }));
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new WashNew();
        });
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
