import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:wash_x/custom/chipbase.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/helpers/washfirebase.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/widgets/wash_bottom_sheet.dart';

//import 'package:wash_x/pages/carpage.dart';
import 'package:wash_x/pages/DryClean/index.dart';
import 'package:wash_x/pages/Laundry/index.dart';
import 'package:wash_x/pages/Basket/index.dart';
import 'package:scoped_model/scoped_model.dart';

//import 'package:wash_x/widgets/addresschange.dart';
//import 'package:wash_x/widgets/appoptions.dart';
//import 'package:wash_x/widgets/timechange.dart';

class WashPage extends StatefulWidget {
  WashPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WashPageState createState() => new _WashPageState();
}

class _WashPageState extends State<WashPage>
    with SingleTickerProviderStateMixin {
  WashModel washModel;
  StreamSubscription _subsWash;
  TabController _tabcontroller;
  String _currentTab;
  WashDatabase washdb;

  Widget bottomSheet;

  @override
  void dispose() {
    if (_subsWash != null) _subsWash.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    washdb = WashDatabase();

    _tabcontroller = new TabController(vsync: this, length: pages.length);
    _tabcontroller.addListener(() {
      setState(() {
        _currentTab = pages[_tabcontroller.index];
      });
    });
    _currentTab = pages[_tabcontroller.index];
    _login();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: washModel == null
          ? new Container(child: Center(child: CircularProgressIndicator()))
          : ScopedModel<WashModel>(
              model: washModel,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: new TabBarView(
                      controller: _tabcontroller,
                      children: <Widget>[
                        new Container(child: new BasketPage()),
                        new Container(child: new LaundryPage()),
                        new Container(child: new DryCleanPage()),
                        new Container(child: new Container()),
                        new Container(child: new Container()),
                      ],
                    ),
                  ),
                  new PreferredSize(
                    preferredSize: Size(250.0, 48.0),
                    child: new Container(
                      margin: new EdgeInsets.all(5.0),
                      decoration: new CustomTabInactive(
                          tabCount: pages.length, width: 250.0),
                      width: 250.0,
                      height: 48.0,
                      child: TabBar(
                        controller: _tabcontroller,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicator: new CustomTabIndicator(),
                        tabs: [
                          Tab(icon: Icon(MyFlutterApp.trash)),
                          Tab(icon: Icon(MyFlutterApp.local_laundry_service)),
                          Tab(icon: Icon(MyFlutterApp.coatrack)),
                          Tab(icon: Icon(Icons.directions_car)),
                          Tab(icon: Icon(Icons.local_car_wash)),
                        ],
                      ),
                    ),
                  ),
//            ScopedModelDescendant<WashModel>(
//              builder: (context, child, model) {
//                return new SingleChildScrollView(
//                  padding: new EdgeInsets.all(8.0),
//                  scrollDirection: Axis.horizontal,
//                  child: new Row(children:[
//                    new WashChip(
//                      bottonSheet: new AddressChange(),
//                      label: new Text(model.address.line1),
//                      avatar: new Icon(MyFlutterApp.place,size: 18.0,)),
//                    new WashChip(
//                      bottonSheet: new CustomTimeChange(),
//                      label: new Text('${model.delivery.weekday}/${model.delivery.time}'),
//                      avatar: new Icon(MyFlutterApp.clock,size: 18.0,)),
//                    new WashChip(
//                      bottonSheet: new AppOptions(),
//                      label: new Text('APP OPTIONS'),
//                      avatar: new Icon(MyFlutterApp.info,size: 18.0,))
//              ]));}),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.all(5.0),
                        child: FloatingActionButton(
                          mini: true,
                          child: new Image.asset(
                            'assets/assistant.png',
                            width: 25.0,
                            height: 25.0,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            //TODO
                          },
                        ),
                      ),
                      new Text(
                        _currentTab,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      new IconButton(
                        icon: new Icon(
                          Icons.more_vert,
                        ),
                        onPressed: () {
                          //TODO
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }

  void _login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: 'alexandrefett@gmail.com', password: 'tuneca2011')
        .then((onValue) {
      washdb.email = onValue.email;
      washdb
          .getWashModel(_updateWash)
          .then((StreamSubscription s) => _subsWash = s);
    });
  }

  _updateWash(WashModel value) {
    setState(() {
      washModel = value;
    });
  }
}

List<String> pages = [
  'BASKET',
  'LAUNDRY',
  'DRY CLEAN',
  'CAR WASH',
  'COUCH WASH'
];
