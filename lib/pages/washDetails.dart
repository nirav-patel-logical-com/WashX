import 'package:flutter/material.dart';
import 'package:wash_x/widgets/setupScreenWidgets.dart';

class WashDetails extends StatefulWidget {
 // final _WashDetailsState _washDetailsState = new _WashDetailsState();

  @override
  _WashDetailsState createState() => new _WashDetailsState();
}

var _washDetailsScaffoldKey = new GlobalKey<ScaffoldState>();

class _WashDetailsState extends State<WashDetails> {
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _washDetailsScaffoldKey,
        body: new Column(
          children: <Widget>[
            new FlatButton.icon(
              color: Colors.white,
              onPressed: () {
                _builWashDetailsBottomSheet();
              },
              label: new Text(
                "SHOW DETAILS",
                style: TextStyle(color: Colors.blue),
              ),
              icon: new Icon(Icons.folder_open),
            ),
            new Expanded(
                child: new ListWardrobe(
              isEditable: false,
            )),
          ],
        ),
      ),
    );
  }

  _builWashDetailsBottomSheet() {
    _washDetailsScaffoldKey.currentState.showBottomSheet((context) {
      return new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return new Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  new BoxShadow(color: Colors.grey, offset: Offset(0.0, -2.0))
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0))),
            height: 500.0,
            width: MediaQuery.of(context).size.width,
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 0.5),
                  width: 40.0,
                  height: 7.0,
                  decoration: new BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(25.0)),
                  //  ),
                ),
                new Expanded(
                  flex: 6,
                  child: _buildCardWash(),
                ),
                new Expanded(
                  flex: 7,
                  child: _buildCardCostDetails(),
                ),
                new Expanded(
                  flex: 7,
                  child: _buildCardCare(),
                ),
                new Expanded(
                  flex: 6,
                  child: _buildCardPickup(),
                ),
              ],
            ));
      });
    });
  }

  _buildCardWash() {
    return new Container(
      //height: 100.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                //offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "WASH",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.people,
                  size: 40.0,
                  color: Colors.grey,
                ),
                Text(
                  "One Bag Wash",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text("ITEMS",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                    new Text(
                      "43",
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Text("TOTAL",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                    new Text(
                      "\$13.28",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCostColumn(String title, String cost) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
        ),
        new Text(
          cost,
          style: TextStyle(color: Colors.grey[700], fontSize: 12.0),
        )
      ],
    );
  }

  _buildCostBtnColumn(VoidCallback callback, String title, String btnLabel) {
    var button = new RaisedButton(
      color: Colors.white,
      splashColor: Colors.blue,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      onPressed: callback,
      textColor: Colors.black,
      child: new Text(
        btnLabel,
        style: TextStyle(color: Colors.blue, fontSize: 12.0),
      ),
    );
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
        ),
        new Expanded(
          flex: 1,
          child: button,
        )
      ],
    );
  }

  _buildCardCostDetails() {
    return new Container(
      //height: 100.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                //offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "COST DETAILS",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: _buildCostColumn("BASE", "\$2.99"),
                ),
                new Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 15.0, left: 10.0, right: 5.0),
                  child: _buildCostColumn("EXTRAS", "\$2.99"),
                ),
                new Expanded(
                  child: new Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    child: _buildCostBtnColumn(() {}, "INSURANCE", "ADD"),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    child: _buildCostBtnColumn(() {}, "EM BEN", "ADD"),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0, left: 10.0),
                  child: _buildCostColumn("TAX", "\$2.99"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCareColumn(String careType) {
    var column = new Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Container(
          child: new CircleAvatar(
            radius: 20.0,
            child: new Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                new BoxShadow(color: Colors.grey[300], spreadRadius: 2.0)
              ]),
        ),
        new Text(
          careType,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.blue),
        ),
      ],
    );

    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: column,
    );
  }

  _buildCardCare() {
    return new Container(
      //height: 100.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                //  offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "CARE",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: false,
              child: new Row(
                children: <Widget>[
                  _buildCareColumn("COLD"),
                  _buildCareColumn("COLORED"),
                  _buildCareColumn("COLD"),
                  _buildCareColumn("COLORED"),
                  _buildCareColumn("COLD"),
                  _buildCareColumn("DRY"),
                  _buildCareColumn("COLORED"),
                  _buildCareColumn("COLD"),
                  _buildCareColumn("DRY"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPickupColumn(String title, String cost) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12.0, color: Colors.blue),
        ),
        new Text(
          cost,
          style: TextStyle(color: Colors.grey[700], fontSize: 12.0),
        )
      ],
    );
  }

  _buildCardPickup() {
    return new Stack(
      children: <Widget>[
        _buildCardPickupBottom(),
        new Padding(
          padding: EdgeInsets.only(right: 5.0, left: 5.0),
          child: _buildCardPickupTop(),
        ),
      ],
    );
  }

  _buildCardPickupTop() {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width - 60.0,
              top: 20.0,
              bottom: 20.0),
          padding: EdgeInsets.only(top: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0)),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey, blurRadius: 1.5, spreadRadius: 2.0)
              ]),
          child: new Column(
            children: <Widget>[
              new Text(
                "PICKUP",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                margin: EdgeInsets.only(left: 10.0, top: 5.0),
                height: 5.0,
                foregroundDecoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.blue,
                ),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0)),
                  color: Colors.blue[100],
                ),
              ),
              new Text(
                "7:40",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              ),
              new Text(
                "PM",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              )
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.only(top: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(color: Colors.white, boxShadow: [
            new BoxShadow(
                offset: Offset(4.5, 0.0),
                color: Colors.grey,
                blurRadius: 1.5,
                spreadRadius: 2.0)
          ]),
          child: new Column(
            children: <Widget>[
              new Text(
                "DROPPED OFF",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                margin: EdgeInsets.only(top: 5.0),
                height: 5.0,
                decoration: new BoxDecoration(
                  color: Colors.blue[100],
                ),
              ),
              new Text(
                "7:40",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              ),
              new Text(
                "PM",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              )
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.only(top: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(color: Colors.white, boxShadow: [
            new BoxShadow(
                offset: Offset(8.0, 0.0),
                color: Colors.grey,
                blurRadius: 1.5,
                spreadRadius: 2.0)
          ]),
          child: new Column(
            children: <Widget>[
              new Text(
                "START WASH",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                height: 5.0,
                margin: EdgeInsets.only(top: 5.0),
                decoration: new BoxDecoration(
                  color: Colors.blue[100],
                ),
              ),
              new Text(
                "7:40",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              ),
              new Text(
                "PM",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              )
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.only(top: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(color: Colors.white, boxShadow: [
            new BoxShadow(
                offset: Offset(11.0, 0.0),
                color: Colors.grey,
                blurRadius: 1.5,
                spreadRadius: 2.0)
          ]),
          child: new Column(
            children: <Widget>[
              new Text(
                "SHIPPED",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                height: 5.0,
                margin: EdgeInsets.only(top: 5.0),
                decoration: new BoxDecoration(
                  color: Colors.blue[100],
                ),
              ),
              new Text(
                "7:40",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              ),
              new Text(
                "PM",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              )
            ],
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          padding: EdgeInsets.only(top: 10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(color: Colors.white, boxShadow: [
            new BoxShadow(
                offset: Offset(14.0, 0.0),
                color: Colors.grey,
                blurRadius: 1.5,
                spreadRadius: 2.0)
          ]),
          child: new Column(
            children: <Widget>[
              new Text(
                "ARRIVED",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                height: 5.0,
                margin: EdgeInsets.only(top: 5.0),
                decoration: new BoxDecoration(
                  color: Colors.blue[100],
                ),
              ),
              new Text(
                "7:40",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              ),
              new Text(
                "PM",
                style: TextStyle(color: Colors.grey[400], fontSize: 12.0),
              )
            ],
          ),
        ),
      ],
    );
  }

  _buildCardPickupBottom() {
    return new Container(
      //height: 100.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                //offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "PICKUP & DROPOFF",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: _buildPickupColumn("BASE", "\$2.99"),
                ),
                new Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 15.0, left: 10.0, right: 5.0),
                  child: _buildPickupColumn("EXTRAS", "\$2.99"),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0, left: 10.0),
                  child: _buildPickupColumn("TAX", "\$2.99"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
