import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/modal_drawer_handle.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/custom/customWashTileActive.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/widgets/washNew.dart';
import 'package:rounded_modal/rounded_modal.dart';

class WashPageNew extends StatefulWidget {
  final RemoteConfig remoteConfig;
  final Function callback;
  WashPageNew({this.remoteConfig,this.callback});
  @override
  _WashPageState createState() => _WashPageState();
}

class _WashPageState extends State<WashPageNew>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> pages = ['BASKET', 'WASH', 'WARDROBE', 'CAR WASH', 'COUCH WASH'];
  String _currentTab;
  bool _isActiveWashVisible = false;
  bool _isWashMoreVisible;

  @override
  void initState() {
    _currentTab = pages[0];
    super.initState();
    _isWashMoreVisible =
        widget.remoteConfig.getBool(Constants.firebaseIsWashMoreVisible);
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      _currentTab = pages[_tabController.index];
      setState(() {});
    });
  }

  var _washScaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController bottomSheetController;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        key: _washScaffoldKey,
        // color: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: _buildTabBarView(),
            ),
            Container(
              margin: EdgeInsets.only(top: 6.0, bottom: 24.0),
              height: 30.0,
              child: RaisedButton(
                onPressed: () {
                  //  _isActiveWashVisible = !_isActiveWashVisible;
                  _showBottomSheet();
                  setState(() {});
                },
                shape: StadiumBorder(),
                color: Colors.white,
                child: Text(
                  _isActiveWashVisible ? "START A WASH" : "ADD TO WASH",
                  style: TextStyle(color: Colors.blue, fontSize: 11.0),
                ),
              ),
            ),
            _buildTabBar(),
            SizedBox(height: 16.0,),
            _isActiveWashVisible
                ? Container()
                : Container(
                  /*height: height / 10 * 3,*/
                  /*decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 1.5),
                          blurRadius: 1.5,
                          spreadRadius: 2.0,
                          color: Colors.grey[350])
                    ],
                  ),*/
                  child: _buildActiveList(),
                ),
            _buildBottomBar()
          ],
        ));
  }

  var height;

  _showBottomSheet() {
    bottomSheetController =
        _washScaffoldKey.currentState.showBottomSheet((context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setter) {
          return WashNew(
            callback: closeBottomSheet,callbackMain: goToWashDetails,

          );
        },
      );
    });
    /*showRoundedModalBottomSheet(
      context: context,
      dismissOnTap: false,
      builder: (context){
        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ModalDrawerHandle(),
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setter) {
                return WashNew(
                  //callback: closeBottomSheet,
                );
              },
            ),
          ],
        );
    });*/
  }

  closeBottomSheet() {
    bottomSheetController.close();
    setState(() {});
  }


  goToWashDetails() {
    widget.callback(PageType.WashDetails);
    setState(() {});
  }

  _buildTabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: <Widget>[
        Container(
          child: Icon(
            MyFlutterApp.trash_2,
            color: Colors.blue,
            size: 150.0,
          ),
        ),
        Container(
          child: Icon(
            MyFlutterApp.local_laundry_service,
            color: Colors.blue,
            size: 150.0,
          ),
        ),
        Container(
          child: Icon(
            MyFlutterApp.coatrack,
            color: Colors.blue,
            size: 150.0,
          ),
        ),
        Container(
          child: Icon(
            Icons.directions_car,
            color: Colors.blue,
            size: 150.0,
          ),
        ),
        Container(
          child: Icon(
            Icons.local_car_wash,
            color: Colors.blue,
            size: 150.0,
          ),
        ),
      ],
    );
  }

  _buildTabBar() {
    return Container(
      // margin: EdgeInsets.only(bottom: 50.0,top: 5.0),
      decoration: CustomTabInactive(tabCount: _tabController.length, width: 250.0),
      width: 250.0,
      height: 48.0,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        indicator: CustomTabIndicator(),
        tabs: [
          Tab(icon: Icon(MyFlutterApp.trash)),
          Tab(icon: Icon(MyFlutterApp.local_laundry_service)),
          Tab(icon: Icon(MyFlutterApp.coatrack)),
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.local_car_wash)),
        ],
      ),
    );
  }

  _buildBottomBar() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: 50.0,
      // decoration: BoxDecoration(color: Colors.white,
      // ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 50.0,
            ),
            Text(_currentTab,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0)),
            IconButton(
              icon: !_isWashMoreVisible
                  ? /*Container(
                      width: 30.0,
                      height: 30.0,
                    )*/
                    Icon(
                      Icons.more_vert,
                      size: 30.0,
                    )
                  : Icon(
                      Icons.tune,
                      size: 30.0,
                    ),
              onPressed: () {},
            )
          ]),
    );
  }

  _buildActiveList() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: WashTileActive(
        item: BasketItem(
          icon: Icon(MyFlutterApp.trash),
          clothe: "Coloured Wash",
          drytype: "dry",
          foldtype: "fold",
          id: "01",
          current: 0.75,
          price: 90.0,
          washtype: "Hello",
          white: true,
        ),
      ),
    );
    /*return ListView(
      children: <Widget>[
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.75,
              price: 90.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.50,
              price: 22.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.90,
              price: 20.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.10,
              price: 10.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.75,
              price: 90.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.50,
              price: 22.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.90,
              price: 20.0,
              washtype: "Hello",
              white: true),
        ),
        WashTileActive(
          item: BasketItem(
              icon: Icon(MyFlutterApp.trash),
              clothe: "Coloured Wash",
              drytype: "dry",
              foldtype: "fold",
              id: "01",
              current: 0.10,
              price: 10.0,
              washtype: "Hello",
              white: true),
        ),
      ],
    );*/
  }
}
