import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wash_x/helpers/firebaseHelper.dart';

class Prefrences extends StatefulWidget {
  final _PrefrencesState _washDetailsState = new _PrefrencesState();

  @override
  _PrefrencesState createState() => _washDetailsState;
}

class _PrefrencesState extends State<Prefrences> with TickerProviderStateMixin {
  TabController _frequencyTabController;
  TabController _speedTabController;
  bool _isAutoOrderSelected = false;
  bool _isDNDSelected = false;
  bool _isTAFSelected = false;

  CollectionReference get messages =>
      Firestore.instance.collection('preference');

  Future<void> _updateAll(bool isAutoOrderSelected) async {
    if (messages != null) {
      messages.document('user1').updateData({
        'address': 'This Update Addresss',
        'time_and_day': 'Sunday, Morning',
        'auto_order': isAutoOrderSelected,
        'do_not_disturb': false,
        'frequency': {
          'WEEKLY': false,
          'BIWEEKLY': true,
        },
        'speed': {
          '6H': false,
          '12H': true,
          '24H': false,
        },
      });
    }
  }

  Future<void> _updateAutoOrder(bool isAutoOrderSelected) async {
    if (messages != null) {
      messages.document('user1').updateData({
        'auto_order': isAutoOrderSelected,
      });
    }
  }

  Future<void> _updateDND(bool isDNDSelected) async {
    if (messages != null) {
      messages.document('user1').updateData({
        'do_not_disturb': isDNDSelected,
      });
    }
  }

  Future<void> _updateFreq(
      String strUpdateValue, var isAutoOrderSelected) async {
    if (messages != null) {
      messages.document('user1').updateData({
        strUpdateValue: isAutoOrderSelected,
      });
    }
  }

  void _handleTabSelection() {
    int selectedTab = _frequencyTabController.index;

    switch (selectedTab) {
      case 0:
        _updateFreq('frequency', {
          'WEEKLY': true,
          'BIWEEKLY': false,
        });
        break;

      case 1:
        _updateFreq('frequency', {
          'WEEKLY': false,
          'BIWEEKLY': true,
        });
        break;
    }
  }

  void _handleSpeedTabSelection() {
    int selectedTab = _speedTabController.index;

    switch (selectedTab) {
      case 0:
        _updateFreq('speed', {
          '6H': true,
          '12H': false,
          '24H': false,
        });
        break;

      case 1:
        _updateFreq('speed', {
          '6H': false,
          '12H': true,
          '24H': false,
        });
        break;

      case 2:
        _updateFreq('speed', {
          '6H': false,
          '12H': false,
          '24H': true,
        });
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _frequencyTabController =
        new TabController(length: 2, vsync: this, initialIndex: 0);
    _speedTabController =
        new TabController(length: 3, vsync: this, initialIndex: 0);

    _frequencyTabController.addListener(_handleTabSelection);
    _speedTabController.addListener(_handleSpeedTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        final int messageCount = snapshot.data.documents.length;

        final DocumentSnapshot document = snapshot.data.documents[0];
        return new SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 50.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                _buildPickupCard(document),
                _buildNotificationCard(),
                _buildSubscriptionCard(),
                _buildPaymentCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildPickupCard(DocumentSnapshot document) {
    String strAddress = "";
    if(document !=null) {
      _isAutoOrderSelected = document['auto_order'];
      _isDNDSelected = document['do_not_disturb'];
      strAddress = document['address'];
      var key_main = document['speed'].keys;
      for (var strMainKey in key_main) {
        switch (strMainKey) {
          case "6H":
            bool isSelected = document['speed'][strMainKey];
            if (isSelected) {
              _speedTabController.animateTo(0, duration: Duration(seconds: 1));
            }
            break;

          case "12H":
            bool isSelected = document['speed'][strMainKey];
            if (isSelected) {
              _speedTabController.animateTo(1, duration: Duration(seconds: 1));
            }
            break;
          case "24H":
            bool isSelected = document['speed'][strMainKey];
            if (isSelected) {
              _speedTabController.animateTo(2, duration: Duration(seconds: 1));
            }
            break;
        }
      }
      var key_friq = document['frequency'].keys;
      for (var strMainKey in key_friq) {
        switch (strMainKey) {
          case "WEEKLY":
            bool isSelected = document['frequency'][strMainKey];
            if (isSelected) {
              _frequencyTabController.animateTo(0,
                  duration: Duration(seconds: 1));
            }
            break;

          case "BIWEEKLY":
            bool isSelected = document['frequency'][strMainKey];
            if (isSelected) {
              _frequencyTabController.animateTo(1,
                  duration: Duration(seconds: 1));
            }
            break;
        }
      }
    }
    return new Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                spreadRadius: 1.5,
                // offset: Offset(5.0, 5.0),
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
            child: new Table(
              columnWidths: {
                1: FlexColumnWidth(2.5),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  new Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(strAddress != null && strAddress.isNotEmpty ? strAddress : "3085 Linton Ave, Motreal,QC,CAH3S 1S4",
                      textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  new Text(
                    "Time & Day",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text("Tuesday Evening", textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  new Text(
                    "Frequency",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60.0, top: 5.0),
                    decoration: new BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: new TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.blue,
                      isScrollable: false,
                      indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25.0)),
                      controller: _frequencyTabController,
                      tabs: <Widget>[
                        new Container(
                          height: 25.0,
                          alignment: Alignment.center,
                          child: new Text(
                            "WEEKLY",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        new Container(
                          height: 25.0,
                          alignment: Alignment.center,
                          child: new Text(
                            "BIWEEKLY",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                TableRow(children: [
                  new Text(
                    "Auto Order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new SwitchListTile(
                    onChanged: (bool newValue) {
                      setState(() {
                        _isAutoOrderSelected = newValue;
                        _updateAutoOrder(_isAutoOrderSelected);
                      });
                    },
                    value: _isAutoOrderSelected,
                    activeColor: Colors.blue,
                  ),
                ]),
                TableRow(children: [
                  new Text(
                    "Speed",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60.0, top: 5.0),
                    decoration: new BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: new TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.blue,
                      isScrollable: false,
                      indicator: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25.0)),
                      controller: _speedTabController,
                      tabs: <Widget>[
                        new Container(
                          height: 25.0,
                          alignment: Alignment.center,
                          child: new Text(
                            "6 H",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        new Container(
                          height: 25.0,
                          alignment: Alignment.center,
                          child: new Text(
                            "12 H",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        new Container(
                          height: 25.0,
                          alignment: Alignment.center,
                          child: new Text(
                            "24 H",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildNotificationCard() {
    return new Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                spreadRadius: 1.5,
                // offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "NOTIFICATIONS",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  new Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: new RaisedButton(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          //  side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0)),
                      color: Colors.blue,
                      onPressed: () {},
                      child: new Text(
                        "MANAGE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  new Text(
                    "Do Not Disturb",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new SwitchListTile(
                    onChanged: (bool newValue) {
                      setState(() {
                        _isDNDSelected = newValue;
                        _updateDND(_isDNDSelected);
                      });
                    },
                    value: _isDNDSelected,
                    activeColor: Colors.blue,
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildSubscriptionCard() {
    return new Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                spreadRadius: 1.5,
                // offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "SUBSCRIPTIONS",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  new Text(
                    "Subscriptions",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: new RaisedButton(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          //  side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0)),
                      color: Colors.blue,
                      onPressed: () {},
                      child: new Text(
                        "MANAGE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ]),
                TableRow(children: [
                  new Text(
                    "Turn All Off",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new SwitchListTile(
                    onChanged: (bool newValue) {
                      setState(() {
                        _isTAFSelected = newValue;
                      });
                    },
                    value: _isTAFSelected,
                    activeColor: Colors.blue,
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildPaymentCard() {
    return new Container(
      height: 120.0,
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
                color: Colors.grey,
                spreadRadius: 1.5,
                // offset: Offset(5.0, 5.0),
                blurRadius: 2.0)
          ]),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "PAYMENTS",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Expanded(
            child: new Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  new Text(
                    "Payments",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: new RaisedButton.icon(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          //  side: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25.0)),
                      color: Colors.white,
                      onPressed: () {},
                      icon: new Icon(Icons.monetization_on),
                      label: new Text("Pay"),
                      // child: new Text(
                      //   "MANAGE",
                      //   style: TextStyle(color: Colors.white),
                      // ),
                    ),
                  )
                ]),
                TableRow(children: [
                  new Text(
                    "Others",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0, top: 10.0),
                    child: new RaisedButton.icon(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      color: Colors.white,
                      onPressed: () {},
                      icon: new Icon(Icons.settings),
                      label: new Text(
                        "Manage",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
