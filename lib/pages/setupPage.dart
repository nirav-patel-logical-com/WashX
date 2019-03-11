import 'dart:async';
import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/helpers/sharedPrefrences.dart';
import 'package:wash_x/pages/beforeSetupPage.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/setupScreenWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SetupPage extends StatefulWidget {
  final _SetupPageState _setupPageState = new _SetupPageState();
  void startAnim() {
    Future.delayed(Duration(seconds: 1), () => _setupPageState.startTime());
  }

  void showTopChip() {
    _setupPageState.showTopChip(true);
  }

  @override
  _SetupPageState createState() => _setupPageState;
}

class _SetupPageState extends State<SetupPage> with TickerProviderStateMixin {
  List<Widget> _itemCards = <Widget>[];
  var _imageFile;
  TextEditingController _addressController = new TextEditingController();
  FlutterTts textTospeech = new FlutterTts();
  TtsState ttsState;
  bool _haswelcomeAppear = false;
  bool _isTopChipVisible = true;
  RemoteConfig remoteConfig;

  @override
  void initState() {
    super.initState();
    setupRemoteConfig();
  }

  void showTopChip(bool visible) {
    _isTopChipVisible = visible;
  }

  startFillingSetup() async {
    var controller = _buildNewAnimationController(time: 500);
    controller.addListener(() {
      setState(() {});
    });
    var controllerCard1 = _buildNewAnimationController(time: 1500);
    controllerCard1.addListener(() {
      setState(() {});
    });
    var controllerCard2 = _buildNewAnimationController(time: 500);
    controllerCard2.addListener(() {
      setState(() {});
    });
    var controllerCard3 = _buildNewAnimationController(time: 500);
    controllerCard3.addListener(() {
      setState(() {});
    });
    var controllerCard4 = _buildNewAnimationController(time: 1500);
    controllerCard4.addListener(() {
      setState(() {});
    });
    var controllerCard5 = _buildNewAnimationController(time: 300);
    controllerCard5.addListener(() {
      setState(() {});
    });

    await Future.delayed(Duration(seconds: 1));
    _itemCards.insert(
        0,
        SetupScreenWidgets.messageBoxLarge(
            Constants.setupLetsSetupMsg, controller));

//start animationg
    controller.forward();
    await textTospeech.speak(Constants.setupLetsSetupMsg);
    controller.addStatusListener((status) async {
      controller.dispose();
      if (status == AnimationStatus.completed) {
        //  _flex=15;

        _itemCards.insert(
            0,
            SetupScreenWidgets.imageBox(
                controllerCard1, "assets/assistant_large.png"));
        await Future.delayed(Duration(seconds: 2));
        controllerCard1.forward();
      }
    });

    controllerCard1.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //   _flex=11;
        controllerCard1.dispose();
        _itemCards.insert(
            0,
            SetupScreenWidgets.messageBox(
                Constants.setupBeforeWeStartMsg, controllerCard2));
        controllerCard2.forward();
        await textTospeech.speak(Constants.setupBeforeWeStartMsg);
      }
    });

    controllerCard2.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //  _flex=9;
        controllerCard2.dispose();
        _itemCards.insert(
            0,
            SetupScreenWidgets.messageBox(
                Constants.setupYourAssistantMsg, controllerCard3));

        await Future.delayed(Duration(seconds: 2));
        controllerCard3.forward();
        await textTospeech.speak(Constants.setupYourAssistantMsg);
      }
    });

    controllerCard3.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //   _flex=3;
        controllerCard3.dispose();
        _itemCards.insert(0, _imageProfile(controllerCard4));
        await Future.delayed(Duration(seconds: 2));
        controllerCard4.forward();
      }
    });
    controllerCard4.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //  _flex=1;
        controllerCard4.dispose();
        _itemCards.insert(
            0,
            SetupScreenWidgets.messageBox(
                Constants.setupLetsStartMsg, controllerCard5));
        controllerCard5.forward();
        await textTospeech.speak(Constants.setupLetsStartMsg);
      }
    });
    controllerCard5.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //    _flex=0;
        controllerCard5.dispose();
      }
    });
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

  startTime() async {
    try {
      await textTospeech.setLanguage("en-US");
      await textTospeech.setSpeechRate(1.0);
      await textTospeech.setVolume(1.0);
      await textTospeech.setPitch(1.0);
      await textTospeech.isLanguageAvailable("en-US");
      // textTospeech.setStartHandler(() {
      //   debugPrint("speeech started");
      //     ttsState = TtsState.PLAYING;
      // });
      // textTospeech.setCompletionHandler(() {
      //   debugPrint("speeech compleatedf");
      //     ttsState = TtsState.STOPPED;
      // });

      // textTospeech.setErrorHandler((msg) {
      //   debugPrint("speeech error");
      //     ttsState = TtsState.STOPPED;
      // });

      _itemCards.insert(0, SetupTopView());
      setState(() {});
      await textTospeech.speak("Hi joan Wike. Let's get you setup.");
    } catch (ex) {
      debugPrint(ex + "hello");
    }
  }

  void _addProfilePicture() {
    debugPrint("Profile picture added");
    _buildBottomSheet();
  }

  //UI building --Start
  FocusNode _focusnode = new FocusNode();
  //bool _isFirstLoad = true;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_focusnode);
          },
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Flexible(
                child: new Stack(
                  children: <Widget>[
                    _buildMainList(),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          height: _isTopChipVisible ? 8.0 : 0.0,
                          width: _isTopChipVisible ? 30.0 : 0.0,
                          decoration: new BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                      ],
                    ),
                    new Positioned(
                      right: 5.0,
                      bottom: 5.0,
                      child: _buildAssistantRow(),
                    )
                  ],
                ),
              ),
              new Divider(
                height: 1.5,
                color: Colors.grey,
              ),
              new Container(
                height: 40.0,
                color: Colors.white,
                child: _buildBottomRow(),
              )
            ],
          ),
        ));
  }

//List Elements --start
  Future<bool> _onWardrobeAdd() async {
    debugPrint("wardrobe added");
    _itemCards.insert(
        0,
        new Container(
          padding: EdgeInsets.only(left: 12.0),
          child: new Text(
            "WARDROBE",
            style: TextStyle(color: Colors.blue, fontSize: 17.0),
          ),
        ));
    _itemCards.insert(0, new ListWardrobe());
    setState(() {});
    return true;
  }

  Future<bool> _onSubmitAddress(String address) async {
    debugPrint("Address submitted" + address);
    var controller = _buildNewAnimationController();
    await _cardMessageBoxLarge(Constants.setupPaymentMethod);
    var controllera = _buildNewAnimationController();
    _itemCards.insert(0, new ListPayments(controllera));
    setState(() {});
    await _cardMessageBoxLarge(Constants.setupWardrobe);
    _itemCards.insert(
        0,
        new Container(
          height: MediaQuery.of(context).size.height / 4,
        ));
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  _addressField(AnimationController controller) {
    return new SizeTransition(
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: new TextField(
            onSubmitted: (String x) async => await _onSubmitAddress(x),
            controller: _addressController,
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              prefixIcon: new IconButton(
                onPressed: null,
                icon: new Icon(Icons.blur_circular),
                color: Colors.black,
              ),
              labelText: "ADDRESS",
              labelStyle: new TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
              hintStyle: new TextStyle(fontSize: 10.0, color: Colors.grey),
              border: new OutlineInputBorder(
                  gapPadding: 8.0,
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.grey, width: 10.0)),
            ),
          ),
        ));
  }

  AnimationController _buildNewAnimationController({time = 500}) {
    var controller = new AnimationController(
      duration: new Duration(milliseconds: time),
      vsync: this,
    );
    return controller;
  }

  Future<bool> _cardMessageBoxLarge(String message) async {
    var controller = _buildNewAnimationController();
    controller.forward();
    _itemCards.insert(
        0, SetupScreenWidgets.messageBoxLarge(message, controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    return true;
  }

  Future<bool> _cardTextFieldBox() async {
    var controller = _buildNewAnimationController(time: 500);
    controller.forward();
    _itemCards.insert(0, _addressField(controller));
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () => controller.dispose());
    Future.delayed(Duration(milliseconds: 600), () {
      _itemCards.insert(
          0,
          new Container(
            height: MediaQuery.of(context).size.height / 3,
          ));
      setState(() {});
    });
    setState(() {});
    return true;
  }

  _cardProfileImage() {
    return new Container(
      height: 150.0,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      child: new CircleAvatar(
        backgroundImage: _imageFile == null
            ? AssetImage("assets/assistant_large.png")
            : FileImage(_imageFile),
        backgroundColor: Colors.white,
        radius: 50.0,
        child: new Container(
          decoration: new BoxDecoration(
              border: Border.all(color: Colors.grey[200], width: 1.0),
              borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
  }

  _imageProfile(AnimationController controller) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      child: new Container(
          height: 150.0,
          alignment: AlignmentDirectional.center,
          child: new GestureDetector(
            onTap: _addProfilePicture,
            child: new Stack(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(20.0),
                  child: new CircleAvatar(
                      backgroundImage: _imageFile == null
                          ? AssetImage("assets/assistant_large.png")
                          : FileImage(_imageFile),
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      child: new Container(
                        decoration: new BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 1.0),
                            borderRadius: BorderRadius.circular(50.0)),
                      )),
                ),
                new Positioned(
                  left: 95.0,
                  top: 80.0,
                  child: new Container(
                    width: 30.0,
                    height: 30.0,
                    child: new Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[200], width: 1.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                )
              ],
            ),
          )),
    );
  }

//List Elements --end

//BottomSheet --start

  RaisedButton _createButton(VoidCallback callback, String text) {
    var button = new RaisedButton(
      elevation: 12.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.blue,
      onPressed: callback,
      textColor: Colors.white,
      child: new Text(text),
    );
    return button;
  }

  Future _changePicture(bool isCamera) async {
    _imageFile = await ImagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    SetupTopView.setImage(_imageFile);
    var pos = _itemCards.length - 6;
    _itemCards.removeAt(pos);
    _itemCards.insert(pos, _cardProfileImage());
    setState(() {});
    Navigator.pop(context);
    _cardMessageBoxLarge(Constants.setupLetsSetupMsg);
    Future.delayed(Duration(milliseconds: 500), () => _cardTextFieldBox());
  }

  _buildBottomSheet() {
    var btnNewPicture = _createButton(
        () async => await _changePicture(true), "Click a new Picture");
    var btnFromGallery = _createButton(
        () async => await _changePicture(false), "Pick From Gallery");

    var button = new RaisedButton(
      elevation: 12.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.blue,
      onPressed: () {},
      textColor: Colors.white,
      child: new Text("Click a new picture"),
    );
    button.onPressed();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.white,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  btnNewPicture,
                  btnFromGallery,
                ],
              ),
            ),
          );
        });
  }

  _buildMainList() {
    return new Container(
        color: Colors.white,
        child: new ListView.builder(
          //  physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => _itemCards[index],
          itemCount: _itemCards.length,
          padding: EdgeInsets.only(bottom: 30.0, left: 35.0, right: 35.0),
          reverse: true,
        ));
  }
  // _buildTopView() {
  //   return new Column(
  //     children: <Widget>[
  //       new Container(
  //         width: 550.0,
  //         margin: EdgeInsets.only(left: 0.0, top: 25.0),
  //         child: new Text(
  //           "Welcome",
  //           textAlign: TextAlign.left,
  //           style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  //         ),
  //       ),
  //       new Container(
  //         width: 550.0,
  //         height: 60.0,
  //         margin: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 15.0),
  //         child: new Row(
  //           children: <Widget>[
  //             new CircleAvatar(
  //               radius: 25.0,
  //                backgroundImage: _imageFile == null
  //                     ? AssetImage("assets/assistant.png")
  //                     : FileImage(_imageFile),
  //               backgroundColor: Colors.white,
  //             ),
  //             new Padding(
  //               padding: EdgeInsets.only(left: 10.0),
  //               child: new Text(
  //                 "Joan Wike",
  //                 style: new TextStyle(fontSize: 20.0),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // _buildTopViewOld() {
  //   return new Column(
  //     children: <Widget>[
  //       new Divider(
  //         color: Colors.grey,
  //         height: 3.0,
  //       ),
  //       new Container(
  //         decoration: new BoxDecoration(
  //           borderRadius: BorderRadius.circular(25.0),
  //           color: Colors.grey[300],
  //         ),
  //         margin: EdgeInsets.only(top: 5.0),
  //         height: 7.0,
  //         width: 30.0,
  //       ),
  //       new Flexible(
  //         flex: 2,
  //         child: Container(
  //           margin: EdgeInsets.only(left: 30.0, top: 25.0),
  //           width: MediaQuery.of(context).size.width,
  //           child: new Text(
  //             "Welcome",
  //             textAlign: TextAlign.left,
  //             style:
  //                 new TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
  //           ),
  //         ),
  //       ),
  //       new Flexible(
  //         flex: 4,
  //         child: Container(
  //           height: 60.0,
  //           margin: EdgeInsets.only(left: 60.0, bottom: 10.0, top: 15.0),
  //           width: MediaQuery.of(context).size.width,
  //           child: new Row(
  //             children: <Widget>[
  //               new CircleAvatar(
  //                 radius: 25.0,
  //                 backgroundImage: _imageFile == null
  //                     ? AssetImage("assets/assistant.png")
  //                     : FileImage(_imageFile),
  //                 backgroundColor: Colors.white,
  //               ),
  //               new Padding(
  //                 padding: EdgeInsets.only(left: 10.0),
  //                 child: new Text(
  //                   "Joan Wike",
  //                   style: new TextStyle(fontSize: 20.0),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _buildAssistant() {
    return new CircleAvatar(
      backgroundColor: Colors.white,
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(new Radius.circular(50.0)),
          border: new Border.all(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
      ),
      backgroundImage: new AssetImage(
        'assets/assistant.png',
      ),
    );
  }

  _buildAssistantRow() {
    var btnSkipLabel = !_haswelcomeAppear ? "SETUP" : "SKIP";
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          height: 25.0,
          color: Colors.transparent,
          padding: EdgeInsets.only(right: 10.0),
          child: new FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.grey)),
            child: new Text(
              btnSkipLabel,
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              debugPrint("skip");
              if (_haswelcomeAppear) {
                _onWardrobeAdd();
              } else {
                _haswelcomeAppear = true;
                startFillingSetup();
              }
            },
          ),
        ),
        new Container(
          color: Colors.transparent,
          width: 25.0,
          height: 25.0,
          child: new InkWell(
            onTap: () {
              debugPrint("main assistant");
              // BeforeSetupPageState.closeTranslateWindow();
            },
            child: _buildAssistant(),
          ),
        ),
        new Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 5.0,
          ),
          child: new Container(
            color: Colors.transparent,
            width: 25.0,
            height: 25.0,
            child: new InkWell(
              onTap: () {
                debugPrint("side kick");
                //  _cardImageBox();
              },
              child: _buildAssistant(),
            ),
          ),
        ),
      ],
    );
  }

  _buildBottomRow() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new IconButton(
            onPressed: () {
              BeforeSetupPageState.closeTranslateWindow();
              _isTopChipVisible = false;
            },
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        new Expanded(
          flex: 5,
          child: new Text(
            "ASSISTANT",
            textAlign: TextAlign.center,
            style: new TextStyle(color: Colors.blue),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new IconButton(
              onPressed: () {
                MySharedPreferences.setSetupCompleteValue(true);

                Navigator
                    .of(context, rootNavigator: true)
                    .push(new CupertinoPageRoute<bool>(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return new MainPage(remoteConfig: remoteConfig,);
                        }));
              },
              icon: new Transform.rotate(
                angle: pi / 2,
                child: Image.asset(
                  'assets/bottomSheet.png',
                  color: Colors.black,
                  fit: BoxFit.fitWidth,
                  width: 20.0,
                ),
              )),
        ),
      ],
    );
  }
  //UI building --end
}
