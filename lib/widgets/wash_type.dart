import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/models/washTypeModel.dart';

class WashTypeList extends StatefulWidget {
  List<WashTypeModels> items;

  WashTypeList({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  _WashTypeState createState() => new _WashTypeState();
}

class _WashTypeState extends State<WashTypeList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _itemsNotSelected = new List<Widget>();
    for (WashTypeModels item in widget.items) {
      _itemsNotSelected.add(Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 130.0,
          width: 130.0,
          child: Card(
            child: Stack(
              children: <Widget>[
                InkWell(
                  child: Image.asset(
                    item.washTypeImage,
                    width: 120.0,
                    height: 120.0,
                  ),
                  onTap: () {
                    setState(() {
                      if (item.isSelected) {
                        item.isSelected = false;
                      } else {
                        item.isSelected = true;
                      }
                    });
                  },
                ),

                item.isSelected ? Container(
                  margin: EdgeInsets.only(left: 10.0,top: 10.0),
                  width: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(color: Colors.black45,),
                    shape: BoxShape.circle

                  ),
                  height: 25.0,
                  child: Icon(Icons.done,color: Colors.white,),
                ):Container(width: 0.0,height: 0.0,),
              ],
            ),
          ),
        ),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _itemsNotSelected,
      ),
    );
  }
}
