import 'package:flutter/material.dart';
import 'package:wash_x/models/model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WashTileActive extends StatefulWidget {
  WashTileActive({this.item});
  final BasketItem item;
  @override
  _WashTileActive createState() => _WashTileActive();
}

class _WashTileActive extends State<WashTileActive> {
  @override
  Widget build(BuildContext context) {
    //print('context.size=${context.size}');
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            leading: widget.item.icon,
            trailing: Icon(Icons.more_vert, color: Colors.black,),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(bottom: 5.0),
                     child: Text(widget.item.clothe,style: TextStyle(fontSize: 12.0),),
                   ),
                   Text('\$${widget.item.price}',style: TextStyle(fontSize: 10.0),)
                  ],
                ),
                Text("PICKED UP",style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
            child: LinearProgressIndicator(
              value: widget.item.current,
              backgroundColor: Colors.blue[100],
            ),
          )
        ],
      ),
    );
  }
}
