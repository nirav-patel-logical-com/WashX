import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/pages/authenticationPage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:wash_x/animations/splashAnimations.dart';
import 'package:wash_x/pages/beforeSetupPage.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/machieneLogos.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage(this.isLoggedIn, this.isAcoountSetupCompleate);
  final bool isLoggedIn;
  final bool isAcoountSetupCompleate;


  @override
  SplashScreenPageState createState() =>
      new SplashScreenPageState(isLoggedIn, isAcoountSetupCompleate);
}

class SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  SplashScreenPageState(this.isLoggedIn, this.isAcoountSetupCompleate);
  final bool isLoggedIn;
  final bool isAcoountSetupCompleate;
  var index = 0;
  Icon extraIcon = new Icon(Icons.vpn_key);
  TextInputType extraKeyboard = TextInputType.text;
  RemoteConfig remoteConfig;

  Color colorEmailLabel = Colors.grey;
  Color colorPasswordLabel = Colors.grey;
  Color colorBackground = Colors.transparent;

  //StatefulWidget page;
  AnimationController animationController;
  //AnimationController slideController;
  SpalshAnimations animation;
  //SlideAnimation slideAnimation;

  @override
  void initState() {
    setupRemoteConfig();
    startTime();
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    // slideController.dispose();
  }

// Initialize state --end
  void startTime() async {
    // print("Timer started");
    Future.delayed(
      const Duration(seconds: 1),
      () => animationController.forward(),
    );
  }
  Future<RemoteConfig> setupRemoteConfig() async {
    remoteConfig = await RemoteConfig.instance;
    // Enable developer mode to relax fetch throttling
    remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
    remoteConfig.setDefaults(<String, dynamic>{
      'welcome': 'default welcome',
      'hello': 'default hello',
    });

    return remoteConfig;
  }

  @override
  void deactivate() {
    super.deactivate();
  }
static final _scaffoldKey = new GlobalKey<ScaffoldState>();

static buildScackbar(SnackBar snackbar){
  _scaffoldKey.currentState.showSnackBar(snackbar);
}

//MAIN UI Building --start
  @override
  Widget build(BuildContext context) {
    //Assigning animations --start
    animation = new SpalshAnimations(animationController, context);
    return new Scaffold(
      key: _scaffoldKey,
        body: new Stack(
      children: <Widget>[
        new Center(
          child: new Container(
            height: animation.squeezeHeight.value,
            width: animation.squeezeWidth.value,
            child: _buildLogo(),
          ),
        ),
        new Material(
          color: Colors.transparent,
          child: _buildTranslateWindow(),
        )
      ],
    ));
  }

  Widget _buildLogo() {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            height: animation.squeezeFlexHeight.value,
          ),
          new Expanded(
            flex: 6,
            child: _buildMainLogo(),
          ),
          new Expanded(
            flex: 4,
            child: new Container(),
          ),
          new Expanded(
            flex: 0,
            child: new Text(
              'Wash X',
              style: new TextStyle(
                  color: animation.squeezeColor.value, fontSize: 25.0),
            ),
          ),
          new Expanded(
            flex: 4,
            child: new Container(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainLogo() {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 2,
          child: new Container(),
        ),
        new Expanded(
            flex: 3,
            child: new Stack(
              children: <Widget>[MachieneLogo.logoColoured()],
            )),
        new Expanded(
          flex: 2,
          child: new Container(),
        ),
      ],
    );
  }

  Widget _buildTranslateWindow() {
    var height = MediaQuery.of(context).size.height -
        animation.translateWindowAnimation.value;
    return new Transform.translate(
      offset: new Offset(0.0, height),
      child: new Container(
        
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: !isLoggedIn
            ? AuthenticationPage()
            : isAcoountSetupCompleate ? MainPage(remoteConfig: remoteConfig,) : BeforeSetupPage(),
      ),
    );
  }

// UI Building end
}
