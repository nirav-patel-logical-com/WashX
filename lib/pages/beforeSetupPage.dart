
import 'package:wash_x/animations/splashAnimations.dart';
import 'package:wash_x/animations/translateAnimation.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/pages/assistantPage.dart';
import 'package:wash_x/pages/setupPage.dart';
import 'package:wash_x/widgets/machieneLogos.dart';
import 'package:flutter/material.dart';

class BeforeSetupPage extends StatefulWidget {
  BeforeSetupPage();
  @override
  BeforeSetupPageState createState() => new BeforeSetupPageState();
}

class BeforeSetupPageState extends State<BeforeSetupPage>
    with SingleTickerProviderStateMixin {

  static AnimationController controller;
  TranslateAnimations animation;
  SetupPage setupPage = new SetupPage();
  AssistantPage assistantPage = new AssistantPage();
  bool _isFirstLaunch = true;

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
    animation = new TranslateAnimations(controller, context);
    return new Scaffold(
        key: beforeSetupKey,
        resizeToAvoidBottomPadding: true,
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
            child: _firstTimeSetupContainer(),
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

  _onAssistantPressed() {
    if (_isFirstLaunch) {
      
      setupPage.startAnim();
      _isFirstLaunch = false;
    }
    controller.forward();
    setupPage.showTopChip();
  }

  var counter = 1;
  
  _firstTimeSetupContainer() {
    return new Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0, bottom: 20.0),
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Text("Welcome Mendy",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0)),
                ),
                new Expanded(
                  flex: 1,
                  child: new Text(
                    Constants.setupBeforeweplaceMsg,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Container(
              child: new FlatButton(
                onPressed: () => _onAssistantPressed(),
                color: Colors.white,
                child: new Text(
                  "SETUP",
                  style: new TextStyle(color: Colors.blue),
                ),
                shape: new RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
