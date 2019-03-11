import 'package:flutter/material.dart';
import 'package:wash_x/widgets/setupScreenWidgets.dart';

class WashOptions extends StatefulWidget {
 // final _WashOptionsState _washDetailsState = new _WashOptionsState();

  @override
  _WashOptionsState createState() => new _WashOptionsState();
}

class _WashOptionsState extends State<WashOptions> {
  var _washOptionsScaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _washOptionsScaffoldKey,
        body: new Column(
          children: <Widget>[
            new FlatButton.icon(
              color: Colors.white,
              onPressed: () {
                _builWashOptionsBottomSheet();
              },
              label: new Text(
                "SHOW DETAILS",
                style: TextStyle(color: Colors.blue),
              ),
              icon: new Icon(Icons.folder_open),
            ),
            new Expanded(
                child: new ListWardrobe(
              isEditable: true,
            )),
          ],
        ),
      ),
    );
  }

  _builWashOptionsBottomSheet() {
    _washOptionsScaffoldKey.currentState.showBottomSheet((context) {
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
            height: 200.0,
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
                  child: _buildContainer(),
                ),
                new Expanded(
                  flex: 7,
                  child: _buildContainer(),
                ),
              ],
            ));
      });
    });
  }

  _buildContainer() {
    return new Container(
      color: Colors.green,
    );
  }
}
