
import 'package:wash_x/animations/splashAnimations.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/pages/assistantPage.dart';
import 'package:wash_x/pages/setupPage.dart';
import 'package:wash_x/widgets/machieneLogos.dart';
import 'package:flutter/material.dart';

class WashAssistantPage extends StatefulWidget {
  final Function callback;
  WashAssistantPage(this.callback);

  @override
  WashAssistantPageState createState() => new WashAssistantPageState();
}

class WashAssistantPageState extends State<WashAssistantPage>
    with SingleTickerProviderStateMixin {
  static AnimationController controller;
  SpalshAnimations animation;
  SetupPage setupPage = new SetupPage();
  AssistantPage assistantPage = new AssistantPage();

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final beforeSetupKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    animation = new SpalshAnimations(controller, context);
    return new Scaffold(
        key: beforeSetupKey,
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            _buildMainScreen(),
            _buildTranslateWindow(),
          ],
        ));
  }

  _buildMainScreen() {
    return new Center(
      child: new Column(
        children: <Widget>[
          new Expanded(
            flex: 3,
            child: new Container(),
          ),
          new Expanded(
              flex: 6,
              child: new AspectRatio(
                aspectRatio: 3.1 / 2.76,
                child: MachieneLogo.buildWashBasket(),
              )),
          new Expanded(
            flex: 2,
            child: new Container(),
          ),
          new Expanded(
              flex: 1,
              child: new Container(
                child: FlatButton(
                  onPressed: () {
                   // this.widget.callback(PageType.FREEWASH);
                    if (counter >= 5) {
                      counter = 0;
                    }
                    _washStatus = WashStatus.values[counter];
                    counter++;

                    setState(() {});
                  },
                  color: Colors.white,
                  child: new Text(
                    "START A WASH",
                    style: new TextStyle(color: Colors.blue),
                  ),
                  shape: new RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey),
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
              )),
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Expanded(
            flex: 5,
            child: _washOptionsContainer(),
          ),
        ],
      ),
      // ),
    );
  }

  static closeTranslateWindow() {
    controller.reverse();
  }

  _buildTranslateWindow() {
    var height = MediaQuery.of(context).size.height -
        animation.translateWindowAnimation.value;
    return new Transform.translate(
      offset: new Offset(0.0, height),
      child: setupPage,
    );
  }

  var counter = 1;

  _washOptionsContainer() {
    return new Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: _buildWashSTatus(),
    );
  }

  WashStatus _washStatus = WashStatus.ENQUEUE;
  _buildWashSTatus() {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Container(),
        ),
        new Expanded(
          flex: 3,
          child: new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: _buildStatusColumn(
                      new Icon(
                        Icons.person,
                        size: 35.0,
                      ),
                      WashStatus.ENQUEUE),
                ),
                new Expanded(
                  flex: 1,
                  child: _buildStatusColumn(
                      new Icon(
                        Icons.people,
                        size: 35.0,
                      ),
                      WashStatus.WASHING),
                ),
                new Expanded(
                  flex: 1,
                  child: _buildStatusColumn(
                      new Icon(
                        Icons.message,
                        size: 35.0,
                      ),
                      WashStatus.DRYING),
                ),
                new Expanded(
                  flex: 1,
                  child: _buildStatusColumn(
                      new Icon(
                        Icons.card_giftcard,
                        size: 35.0,
                      ),
                      WashStatus.IRONING),
                ),
                new Expanded(
                  flex: 1,
                  child: _buildStatusColumn(
                      new Icon(
                        Icons.shopping_cart,
                        size: 35.0,
                      ),
                      WashStatus.OUTFORDELIEVERY),
                ),
              ],
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Container(),
        )
      ],
    );
  }

  _buildStatusColumn(Widget icon, WashStatus status) {
    return new Column(
      children: <Widget>[
        new Expanded(
          flex: 6,
          child: new Container(),
        ),
        new Expanded(
          flex: 6,
          child: new Container(
            child: icon,
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Container(),
        ),
        new Expanded(
          flex: 1,
          child: new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: new BoxDecoration(
                color:
                    _washStatus == status ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
        ),
        new Expanded(
          flex: 2,
          child: new Container(),
        ),
      ],
    );
  }

}
