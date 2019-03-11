import 'package:wash_x/pages/authenticationPage.dart';
import 'package:wash_x/widgets/helperWidgets.dart';
import 'package:wash_x/widgets/machieneLogos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage(this.isFromSplash, [this.userName = 'Welcome']);
  final bool isFromSplash;
  String userName;
  @override
  _HomePageState createState() =>
      new _HomePageState(isFromSplash, userName);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.isFromSplash, this.userName);
  String userName;
  final bool isFromSplash;
  FirebaseUser user;
  TextEditingController controllerEmail;
  String email;
  @override
  void initState() {
    super.initState();
    controllerEmail = new TextEditingController();
    controllerEmail.text = userName;
    _getEmail();
  }

  _getEmail() async {
    user = await FirebaseAuth.instance
        .currentUser()
        .then((user) => _getUserEmail(user));
  }

  _getUserEmail(FirebaseUser user) async {
    if (user != null) {
      setState(() {
        controllerEmail.text = user.email;
      });
    }
  }

  _buildMainLogo() {
    return new Column(
      children: <Widget>[
        new Expanded(
          flex: 12,
          child: new Container(),
        ),
        new Expanded(
          flex: 15,
          child: MachieneLogo.logoColoured(),
        ),
        new Expanded(
          flex: 12,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text(
                'Welcome',
                style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
              ),

              new TextField(
                controller: controllerEmail,
                decoration: null,
                enabled: false,
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.blue[400], fontSize: 10.0),
              ),
            ],
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: new AppBar(
            leading: new Container(),
            title: new Center(
              child: new Container(
                width: 200.0,
                child: Text('Welcome Page'),
              ),
            )),
        floatingActionButton: new FloatingActionButton.extended(
          icon: new Icon(Icons.exit_to_app),
          label: new Text("Log out"),

          onPressed: () {
            if (!isFromSplash) {
              Navigator
                  .of(context, rootNavigator: true)
                  .pushReplacement(new CupertinoPageRoute<bool>(
                      fullscreenDialog: true,
                      builder: (BuildContext context) {
                        FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                      }));
            }
            else{
               FirebaseAuth.instance.signOut();
               Navigator
        .of(context, rootNavigator: true)
        .push(new CupertinoPageRoute<bool>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new AuthenticationPage();
            }));
            }
          },
        ),
        body: new Container(
          color: Colors.white,
          child: new Row(
            children: <Widget>[
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
              new Expanded(
                flex: 3,
                child: _buildMainLogo(),
              ),
              new Expanded(
                flex: 2,
                child: new Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
