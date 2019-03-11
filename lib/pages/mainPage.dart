import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/animations/splashAnimations.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/custom/custom_time_change.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/free-wash.dart';
import 'package:wash_x/giftwash/contacts-list.dart';
import 'package:wash_x/giftwash/gift-wash.dart';
import 'package:wash_x/global.dart';
import 'package:wash_x/helpcentre/helpcenter.dart';
import 'package:wash_x/helpers/firebaseHelper.dart';
import 'package:wash_x/helpers/sharedPrefrences.dart';
import 'package:wash_x/models/feedback-model.dart';
import 'package:wash_x/models/navigationModel.dart';
import 'package:wash_x/pages/assistantPage.dart';
import 'package:wash_x/pages/feedback_itam_list.dart';
import 'package:wash_x/pages/history_page.dart';
import 'package:wash_x/pages/newTestPage.dart';
import 'package:wash_x/pages/prefrencesWidget.dart';
import 'package:wash_x/pages/wardrobePage.dart';
import 'package:wash_x/pages/washAssistantPage.dart';
import 'package:wash_x/pages/washDetails.dart';
import 'package:wash_x/pages/washOptions.dart';
import 'package:wash_x/pages/washPage.dart';
import 'package:wash_x/widgets/addresschange.dart';
//import 'package:speech_recognition/speech_recognition.dart';

class MainPage extends StatefulWidget {
  final RemoteConfig remoteConfig;

  MainPage({this.remoteConfig});

  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  static AnimationController controller;
  SpalshAnimations animation;
  AssistantPage assistantPage = new AssistantPage();

  List<NavigationModel> _recentPages = [];
  Widget currentPage;
  bool _isAsstLstVisible = false;
  bool isVoiceAssistantVisible;
  bool isSwipeFunctionAvailable;
  PersistentBottomSheetController bottomSheetController;
  double _assistantMargin = 55.0;

  //SpeechRecognition _speechToText;

  ///bool _speechRecognitionAvailable = false;
  // bool _isListening = false;

  String transcription = '';

//  String _currentLocale = 'en_US';
  List<bool> _indexTimeList = new List();

  PageType currentPageType;
  TabController _tabController;

  List<FeedbackModel> _items = <FeedbackModel>[
    FeedbackModel(
        myController0: TextEditingController(),
        myController1: TextEditingController(),
        myController2: TextEditingController()),
    FeedbackModel(
        myController0: TextEditingController(),
        myController1: TextEditingController(),
        myController2: TextEditingController()),
    FeedbackModel(
        myController0: TextEditingController(),
        myController1: TextEditingController(),
        myController2: TextEditingController())
  ];
  bool _twoStepAuth = false;

  DocumentSnapshot userDocument = null;

  @override
  void initState() {
    super.initState();
    isVoiceAssistantVisible =
        widget.remoteConfig.getBool(Constants.firebaseIsVoiceAssistantVisible);
    isSwipeFunctionAvailable =
        widget.remoteConfig.getBool(Constants.firebaseIsSwipeFunctionAvailable);
    _tabController = TabController(vsync: this, length: _items.length);
    if (currentPage == null || _recentPages.length == 0) {
      currentPage = WashPageNew(
        remoteConfig: widget.remoteConfig,
        callback: this.callback,
      );
      currentPageType = PageType.WASHPAGE;
    }
    controller = new AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
    //  activateSpeechRecognizer();
    _getUserAccount();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // void activateSpeechRecognizer() {
  //   print('_MyAppState.activateSpeechRecognizer... ');
  //   _speechToText = new SpeechRecognition();
  //   _speechToText.setAvailabilityHandler(onSpeechAvailability);
  //   _speechToText.setCurrentLocaleHandler(onCurrentLocale);
  //   _speechToText.setRecognitionStartedHandler(onRecognitionStarted);
  //   _speechToText.setRecognitionResultHandler(onRecognitionResult);
  //   _speechToText.setRecognitionCompleteHandler(onRecognitionComplete);
  //   _speechToText
  //       .activate()
  //       .then((res) => setState(() => _speechRecognitionAvailable = res));
  // }

  // void start() => _speechToText
  //     .listen(locale: _currentLocale)
  //     .then((result) => print('_MyHomePageState.start => result ${result}'));

  // void cancel() => _speechToText.cancel().then((result) => setState(() {
  //       _isListening = result;
  //       debugPrint("cancel called");
  //     }));

  // void stop() => _speechToText.stop().then((result) => setState(() {
  //       _isListening = result;
  //       debugPrint("stop called");
  //     }));

  // void onSpeechAvailability(bool result) =>
  //     setState(() => _speechRecognitionAvailable = result);

  // void onCurrentLocale(String locale) =>
  //     setState(() => _currentLocale = locale);

  // void onRecognitionStarted() => setState(() {
  //       _isListening = true;
  //       debugPrint("started");
  //     });

  // void onRecognitionResult(String text) => setState(() {
  //       transcription = text;

  //       debugPrint("result");
  //     });

  // void onRecognitionComplete() => setState(() {
  //       _isListening = false;
  //       _speechToText.stop();
  //       _speechToText.cancel();
  //       assistantPage.handleSubmittedVoice(transcription);
  //       debugPrint("compleated");
  //     });

//Navigate
  List<CameraDescription> cameras;

  void callback(PageType nextPage) async {
    Widget navigationPage;
    if (nextPage == PageType.HOMEPAGE) {
      navigationPage = new HomePage(callback, false);
    } else if (nextPage == PageType.WASHASSISTANTPAGE) {
      navigationPage = WashAssistantPage(this.callback);
    } else if (nextPage == PageType.FREEWASH) {
      navigationPage = FreeWash();
    } else if (nextPage == PageType.ACCOUNT) {
      // navigationPage = MyHomePage();
    } else if (nextPage == PageType.WashDetails) {
      navigationPage = WashDetails();
    } else if (nextPage == PageType.WashOptions) {
      navigationPage = WashOptions();
    } else if (nextPage == PageType.WARDROBE) {
      navigationPage = WardrobePage();
    } else if (nextPage == PageType.HISTORY) {
      navigationPage = History(this.callback);
    } else if (nextPage == PageType.GIFTWASH) {
      navigationPage = GiftWash(this.callback);
    } else if (nextPage == PageType.HELPCENTER) {
      navigationPage = HelpCenter(this.callback, this.widget.remoteConfig);
    } else if (nextPage == PageType.WASHPAGE) {
      navigationPage = WashPageNew(
        remoteConfig: widget.remoteConfig,
        callback: this.callback,
      );
    } else if (nextPage == PageType.CONTACT) {
      navigationPage = ContactList(this.callback);
    }

    _setAssistantBottomMargin(nextPage);
    _recentPages
        .add(new NavigationModel(page: currentPage, pageType: currentPageType));
    _isAsstLstVisible = false;
    this.currentPageType = nextPage;
    this.currentPage = navigationPage;
    setState(() {});
  }

  // get user and App option bottom Sheet Start
  getOptionList(int optionType) {
    final List<Widget> list = new List();

    switch (optionType) {
      // User option
      case 0:
        String userOptions =
            widget.remoteConfig.getString(Constants.firebaseUserOption);

        if (userOptions != null && userOptions.isNotEmpty) {
          for (var item in json.decode(userOptions)) {
            bool is_active = item[Constants.RES_IS_ACTIVE];
            int menu_id = item[Constants.RES_MENU_ID];
            String menu_image = item[Constants.RES_MENU_IMAGE];
            String menu_title = item[Constants.RES_MENU_TITLE];

            if (is_active) {
              list.add(InkResponse(
                highlightShape: BoxShape.rectangle,
                highlightColor: Colors.black26,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  height: 40.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 0,
                        child: CachedNetworkImage(
                          imageUrl: menu_image,
                          placeholder: Container(
                            height: 18.0,
                            width: 18.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                      new Expanded(
                        flex: 0,
                        child: new Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: new Text(menu_title),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  switch (menu_id) {
                    //Account
                    case 1:
                      bottomSheetController.close();
                      //callback(PageType.ACCOUNT);
                      _showAccountSheet();
                      _closeMainMenu();
                      break;

                    //Prefrence
                    case 2:
                      bottomSheetController.close();
                      //  callback(PageType.PREFRENCES);
                      _showPreferenceSheet();
                      _closeMainMenu();
                      break;

                    //Wardrobe
                    case 3:
                      bottomSheetController.close();
                      callback(PageType.WARDROBE);
                      _closeMainMenu();
                      break;

                    //History
                    case 4:
                      bottomSheetController.close();
                      callback(PageType.HISTORY);
                      _closeMainMenu();
                      break;

                    //Free Wash
                    case 5:
                      bottomSheetController.close();
                      callback(PageType.FREEWASH);
                      _closeMainMenu();
                      break;

                    //Gift A Wash
                    case 6:
                      bottomSheetController.close();
                      callback(PageType.GIFTWASH);
                      _closeMainMenu();
                      break;
                  }
                },
              ));
            }
          }
        }
        break;

      // App option
      case 1:
        String appOptions =
            widget.remoteConfig.getString(Constants.firebaseAppOption);

        if (appOptions != null && appOptions.isNotEmpty) {
          for (var item in json.decode(appOptions)) {
            bool is_active = item[Constants.RES_IS_ACTIVE];
            int menu_id = item[Constants.RES_MENU_ID];
            String menu_image = item[Constants.RES_MENU_IMAGE];
            String menu_title = item[Constants.RES_MENU_TITLE];

            if (is_active) {
              list.add(InkResponse(
                highlightShape: BoxShape.rectangle,
                highlightColor: Colors.black26,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  height: 40.0,
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          flex: 0,
                          child: CachedNetworkImage(
                            imageUrl: menu_image,
                            placeholder: Container(
                              height: 18.0,
                              width: 18.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                            height: 20.0,
                            width: 20.0,
                          )),
                      new Expanded(
                        flex: 0,
                        child: new Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: new Text(menu_title),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  switch (menu_id) {
                    //Update
                    case 1:
                      bottomSheetController.close();
                      //callback(PageType.ACCOUNT);
                      _closeMainMenu();
                      break;

                    //About
                    case 2:
                      bottomSheetController.close();
                      //callback(PageType.CAREPREFRENCES);
                      _closeMainMenu();
                      break;

                    //Help Center
                    case 3:
                      bottomSheetController.close();
                      callback(PageType.HELPCENTER);
                      _closeMainMenu();
                      break;

                    //Feedback
                    case 4:
                      bottomSheetController.close();
                      if (_isAssistantClosed) _showFeedbackSheet(0);
                      _closeMainMenu();
                      break;

                    //User Guide
                    case 5:
                      bottomSheetController.close();
                      _closeMainMenu();
                      break;

                    //Take A Tour
                    case 6:
                      bottomSheetController.close();
                      // callback(PageType.WASH);
                      break; //Take A Tour

                    //Rate Us
                    case 7:
                      bottomSheetController.close();
                      if (_isAssistantClosed) _showRateUsSheet(0);
                      _closeMainMenu();
                      break;
                  }
                },
              ));
            }
          }
        }
        break;
    }

    return Container(
        height: 300.0,
        margin: EdgeInsets.only(top: 20.0),
        child: new ListView.builder(
          itemBuilder: (_, int index) => list[index],
          itemCount: list.length,
          reverse: false,
        ));
  }

  // get user and App option bottom Sheet End

  // get Feedback Menu Start
  _getFeedbackMenu() {
    final List<Widget> list = new List();

    String feedbackMenu =
        widget.remoteConfig.getString(Constants.firebaseFeedbackMenu);

    if (feedbackMenu != null && feedbackMenu.isNotEmpty) {
      for (var item in json.decode(feedbackMenu)) {
        bool is_active = item[Constants.RES_IS_ACTIVE];
        int menu_id = item[Constants.RES_MENU_ID];
        //String menu_image = item[Constants.RES_MENU_IMAGE];
        String menu_title = item[Constants.RES_MENU_TITLE];
        if (is_active) {
          list.add(InkResponse(
            highlightShape: BoxShape.rectangle,
            highlightColor: Colors.black26,
            child: Container(
              padding: EdgeInsets.all(6.0),
              margin: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(20.0),
                    bottomLeft: new Radius.circular(20.0),
                    topRight: new Radius.circular(20.0),
                    bottomRight: new Radius.circular(20.0),
                  ),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1.0,
                    )
                  ]),
              child: InkResponse(
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: new Icon(Icons.add,
                          size: 18.0, color: Colors.blueAccent),
                    ),
                    new Text(
                      menu_title.toUpperCase(),
                      style: new TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onTap: () {},
                highlightShape: BoxShape.rectangle,
                highlightColor: Colors.black54,
              ),
            ),
            onTap: () {
              switch (menu_id) {
                //Account
                case 1:
                  bottomSheetController.close();
                  // callback(PageType.ACCOUNT);
                  break;

                //Prefrence
                case 2:
                  bottomSheetController.close();
                  _showPreferenceSheet();
                  break;
              }
            },
          ));
        }
      }
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
      ),
      margin: EdgeInsets.only(top: list.isEmpty ? 45.0 : 0.0),
    );
  }

  // get feedback menu End
  _closeMainMenu() {
    setState(() {
      _isAsstLstVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    animation = new SpalshAnimations(controller, context);
    return new SafeArea(
        top: true,
        child: new WillPopScope(
            onWillPop: () => onWillPop(_isAsstLstVisible),
            child: new GestureDetector(
                onTap: () {
                  if (bottomSheetController != null)
                    bottomSheetController.close();
                },
                onTapDown: (TapDownDetails details) {
                  if (bottomSheetController != null)
                    bottomSheetController.close();
                },
                onHorizontalDragStart: (x) => _dragStart(x),
                onHorizontalDragUpdate: (x) => _dragEnd(x),
                child: new Material(
                  color: Colors.white,
                  child: new Stack(
                    children: <Widget>[
                      _buildPageGenerate(),
                      _buildTranslateWindow(),
                      new Positioned(bottom: 0.0, child: _buildAssistant()),
                    ],
                  ),
                ))));
  }

  final currentPageKey = new GlobalKey<ScaffoldState>();

  // final _assistantScaffoldKey = new GlobalKey<ScaffoldState>();

//Generate the Page displayed with assistant
  _buildPageGenerate() {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      key: currentPageKey,
      body: new Container(
        //margin: EdgeInsets.only(bottom: 50.0),
        child: currentPage,
      ),
    );
  }

  _getUserAccount() async {
    userDocument = await FirebaseHelper.getUserByEmail('mendymarcus@gmail.com');
  }

  _showPreferenceSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          height: (MediaQuery.of(context).size.height / 5) * 4,
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.only(top: 5.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                    blurRadius: 5.0,
                    //spreadRadius: 3.0,
                    color: Colors.grey)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              new Expanded(
                child: Prefrences(),
              )
            ],
          ));
    });
  }

  _showItemSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              //    border: Border.all(color: Colors.transparent),
              boxShadow: [
                new BoxShadow(
                    blurRadius: 5.0,
                    //spreadRadius: 3.0,
                    color: Colors.grey)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              new Column(
                children: <Widget>[
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                  new Text("data"),
                ],
              )
            ],
          ));
    });
  }

  _showAddressChangeSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
        margin: EdgeInsets.only(top: 5.0),
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [new BoxShadow(blurRadius: 5.0, color: Colors.grey)],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
        child: new AddressChange(),
      );
    });
  }

  /// Display User Options item SheetÌµ
  _showUserOptionItemSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              //    border: Border.all(color: Colors.transparent),
              boxShadow: [
                new BoxShadow(
                    blurRadius: 5.0,
                    //spreadRadius: 3.0,
                    color: Colors.grey)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              Row(
                children: <Widget>[
                  new CircleAvatar(
                    backgroundImage: new NetworkImage(
                        'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg'),
                    radius: 25.0,
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'Mendy Marcus',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              new Text(
                                'mendymarcus@gmail.com',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12.0),
                              ),
                            ],
                          ))),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkResponse(
                      onTap: () {
                        bottomSheetController.close();
                        // callback(PageType.FREEWASH);
                      },
                      child: new Text(
                        'Logout',
                        style: TextStyle(color: Colors.black87, fontSize: 14.0),
                      ),
                    ),
                  )
                ],
              ),
              getOptionList(0)
              //new UserOptions(remoteConfig: widget.remoteConfig,)
            ],
          ));
    });
  }

  /// Display App Options item SheetÌµ
  _showAppOptionItemSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              //    border: Border.all(color: Colors.transparent),
              boxShadow: [
                new BoxShadow(
                    blurRadius: 5.0,
                    //spreadRadius: 3.0,
                    color: Colors.grey)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              getOptionList(1),
              Container(
                height: 30.0,
              )
              //new UserOptions(remoteConfig: widget.remoteConfig,)
            ],
          ));
    });
  }

  // show feedback sheet
  _showFeedbackSheet(int screenPosition) {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      double textPadding = 25.0;
      return new Stack(
        children: <Widget>[
          screenPosition == 0
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                        Container(
                          margin: new EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "FEEDBACK",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 88.0,
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Colors.black12),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(8.0))),
                          margin: new EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.announcement,
                                size: 18.0,
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 6.0, top: 4.0)),
                              Expanded(
                                  child: Container(
                                child: TextField(
                                  maxLines: 3,
                                  keyboardType: TextInputType.multiline,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      decorationColor: Colors.black),
                                  decoration: new InputDecoration.collapsed(
                                    hintText: "Whats on your mind?",
                                    hintStyle: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: textPadding),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _getFeedbackMenu(),
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                    _showFeedbackSheet(1);
                                  },
                                  child: Text(
                                    "NEXT",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 35.0, top: 20.0),
                          padding: EdgeInsets.only(top: 10.0),
                        )

                        /*Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(6.0),
                      margin: new EdgeInsets.all(10.0),
                      width: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1.0,
                            )
                          ]),
                      child: InkResponse(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: new Icon(Icons.add,
                                  size: 18.0, color: Colors.blueAccent),
                            ),
                            new Text(
                              'FEATURE',
                              style: new TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        onTap: () {},
                        highlightShape: BoxShape.rectangle,
                        highlightColor: Colors.black54,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: new EdgeInsets.all(10.0),
                      width: 80.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1.0,
                            )
                          ]),
                      child: InkResponse(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: new Icon(Icons.add,
                                  size: 18.0, color: Colors.blueAccent),
                            ),
                            new Text(
                              'TOPIC',
                              style: new TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        onTap: () {},
                        highlightColor: Colors.black54,
                        highlightShape: BoxShape.rectangle,
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 35.0),
              ), Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(6.0),
                      margin: new EdgeInsets.all(10.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1.0,
                            )
                          ]),
                      child: InkResponse(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new Text(
                                'BUGS',
                                style: new TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(Icons.cancel,
                                  size: 18.0, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                        onTap: () {},
                        highlightShape: BoxShape.rectangle,
                        highlightColor: Colors.black54,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: new EdgeInsets.all(10.0),
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: new Radius.circular(20.0),
                            bottomLeft: new Radius.circular(20.0),
                            topRight: new Radius.circular(20.0),
                            bottomRight: new Radius.circular(20.0),
                          ),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1.0,
                            )
                          ]),
                      child: InkResponse(
                        child: new Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: new Text(
                                'BUGS',
                                style: new TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(Icons.cancel,
                                  size: 18.0, color: Colors.blueAccent),
                            ),

                          ],
                        ),
                        onTap: () {},
                        highlightColor: Colors.black54,
                        highlightShape: BoxShape.rectangle,
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.only(left: 35.0),
              ),*/
                      ],
                    ),
                  ),
                )
              : Container(height: 0.0),
          screenPosition == 1
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                        Container(
                          margin: new EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "This may help, here is what found in out Help Center",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        FeedBackItemList(
                            sliders: _items,
                            tabController: _tabController,
                            height: 350.0),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: InkResponse(
                            child: Container(
                              alignment: Alignment.center,
                              width: 80.0,
                              padding: EdgeInsets.all(6.0),
                              margin: new EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: new Radius.circular(20.0),
                                    bottomLeft: new Radius.circular(20.0),
                                    topRight: new Radius.circular(20.0),
                                    bottomRight: new Radius.circular(20.0),
                                  ),
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 1.0,
                                    )
                                  ]),
                              child: Text(
                                "SEND",
                                style: new TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            splashColor: Colors.blue,
                            highlightShape: BoxShape.rectangle,
                            onTap: () {
                              bottomSheetController.close();
                              _showFeedbackSheet(2);
                              var duration = new Duration(seconds: 1);
                              new Timer(duration, _closeBottomSheet);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 0.0,
                ),
          screenPosition == 2
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Container(
                          width: 50.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          )),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        decoration: ShapeDecoration(
                            shape: CircleBorder(
                                side: BorderSide(
                                    width: 0.8, color: Colors.black))),
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 50.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 20.0, bottom: 30.0, left: 30.0, right: 30.0),
                        child: Text(
                          "Thank you, we have recived it and will be in touch soon",
                          style: new TextStyle(
                              color: Colors.black, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ))
              : Container(
                  height: 0.0,
                )
        ],
      );
    });
  }

  // show Rate Us
  _showRateUsSheet(int screenPosition) {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Stack(
        children: <Widget>[
          screenPosition == 0
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                        Container(
                          margin: new EdgeInsets.only(
                              top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Are you enjoying you expirience on Wash X?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                    _showRateUsSheet(2);
                                  },
                                  child: Text(
                                    "NO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                    _showRateUsSheet(1);
                                  },
                                  child: Text(
                                    "YES",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 35.0, top: 20.0),
                          padding: EdgeInsets.only(top: 10.0),
                        )
                      ],
                    ),
                  ),
                )
              : Container(height: 0.0),
          screenPosition == 1
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                        Container(
                          margin: new EdgeInsets.only(
                              top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Would you like to rate us?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                  },
                                  child: Text(
                                    "NOT REALY",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                    _showRateUsSheet(2);
                                  },
                                  child: Text(
                                    "SURE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 35.0, top: 20.0),
                          padding: EdgeInsets.only(top: 10.0),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 0.0,
                ),
          screenPosition == 2
              ? Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      //    border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 5.0,
                            //spreadRadius: 3.0,
                            color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0))),
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Container(
                            width: 50.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            )),
                        Container(
                          margin: new EdgeInsets.only(
                              top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Please let us know how we can improve",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                  },
                                  child: Text(
                                    "NEVERMIEND",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              FlatButton(
                                  onPressed: () {
                                    bottomSheetController.close();
                                  },
                                  child: Text(
                                    "SURE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          margin: EdgeInsets.only(left: 35.0, top: 20.0),
                          padding: EdgeInsets.only(top: 10.0),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 0.0,
                )
        ],
      );
    });
  }

  // Show Account Sheet Start
  _showAccountSheet() {
    _getUserAccount();
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            color: Colors.white,
            //    border: Border.all(color: Colors.transparent),
            boxShadow: [
              new BoxShadow(
                  blurRadius: 5.0,
                  //spreadRadius: 3.0,
                  color: Colors.grey)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),

              Card(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "PROFILE",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10.2,
                              fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      ),
                      Row(
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundImage: new NetworkImage(userDocument !=
                                        null &&
                                    userDocument['ProPic'] != null
                                ? userDocument['ProPic']
                                : 'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg'),
                            radius: 25.0,
                          ),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: new Text(
                                    userDocument != null
                                        ? userDocument['User Name']
                                        : 'Mendy Marcus',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400),
                                  ))),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            alignment: Alignment.centerRight,
                            child: InkResponse(
                              onTap: () {
                                bottomSheetController.close();
                              },
                              child: new Text(
                                'LOGOUT',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 12.0),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomRight: new Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1.0,
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(8.0))),
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
              Card(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "CONTACT",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10.2,
                              fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Container(
                                child: new Icon(Icons.person_pin),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: InkWell(
                                    onTap: () => debugPrint("test"),
                                    child: Text(
                                      userDocument != null
                                          ? userDocument['First Name'] +
                                              userDocument['Last Name']
                                          : "mendymarcus",
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                new Container(
                                  child: new Icon(Icons.mail),
                                ),
                                new Expanded(
                                  child: new Container(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      userDocument != null
                                          ? userDocument['Email']
                                          : "mendymarcus@gmail.com",
                                      style: TextStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(8.0))),
              ),
              Padding(padding: EdgeInsets.only(top: 2.0)),
              Card(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "SECURITY",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10.2,
                              fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new Container(
                                child: new Icon(Icons.lock),
                              ),
                              new Expanded(
                                child: new Container(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "*******",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              new Container(
                                child: new Icon(Icons.verified_user),
                              ),
                              new Expanded(
                                child: new SwitchListTile(
                                  value: _twoStepAuth,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      _twoStepAuth = newValue;
                                    });
                                  },
                                  title: new Text(
                                    "Two-Step Verification",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(8.0))),
              ),
              Padding(padding: EdgeInsets.only(top: 2.0)),
              Card(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "DANGER ZONE",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 10.2,
                              fontWeight: FontWeight.bold),
                        ),
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      ),
                      Row(
                        children: <Widget>[
                          new Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          Expanded(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 16.0),
                                  child: new Text(
                                    'Close my account but keep my data incase i want to reopen at some point',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                  ))),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            alignment: Alignment.centerRight,
                            child: InkResponse(
                              onTap: () {
                                bottomSheetController.close();
                              },
                              child: new Text(
                                'CLOSE',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12.0),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomRight: new Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1.0,
                                  )
                                ]),
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Row(
                        children: <Widget>[
                          new Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          Expanded(
                              child: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 14.0),
                                  child: new Text(
                                    'Permanetly Delete Account and all my data',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12.0,
                                    ),
                                  ))),
                          Container(
                            padding: EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                            alignment: Alignment.centerRight,
                            child: InkResponse(
                              onTap: () {
                                bottomSheetController.close();
                              },
                              child: new Text(
                                'DELETE',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomRight: new Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 0.0,
                                  )
                                ]),
                          )
                        ],
                      )
                    ],
                  ),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(8.0),
                    border: new Border.all(
                      width: 1.0,
                      color: Colors.red,
                    ),
                  ),
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(8.0))),
              ),
              Container(
                height: 40.0,
              )
              //new UserOptions(remoteConfig: widget.remoteConfig,)
            ],
          ),
        ),
      );
    });
  }

// Show Account Sheet End
  _closeBottomSheet() {
    bottomSheetController.close();
  }

  _showTimeChangeSheet() {
    for (var i = 0; i < 12; i++) {
      _indexTimeList.add(false);
    }

    ScrollController _dayLabelController = new ScrollController();
    ScrollController _dayIconController = new ScrollController();
    _dayIconController.addListener(() {
      if (_dayIconController.offset >= 200.0 &&
          _dayIconController.offset < 400.0) {
        _dayLabelController.animateTo(220.0,
            curve: Curves.ease, duration: Duration(milliseconds: 100));
      } else if (_dayIconController.offset >= 400.0 &&
          _dayIconController.offset < 600) {
        _dayLabelController.animateTo(440.0,
            curve: Curves.ease, duration: Duration(milliseconds: 100));
      } else if (_dayIconController.offset < 140.0) {
        _dayLabelController.animateTo(0.0,
            curve: Curves.ease, duration: Duration(milliseconds: 100));
      } else if (_dayIconController.offset > 450.0) {}
    });

    bool _isSelectedContainerVisible = false;

    var _selectedPickUpTimeContainer = new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "TOMMOROW",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          new Row(
            children: <Widget>[
              new CustomTime(
                isselected: false,
                callback: () {},
                index: 0,
              ),
              new Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 70.0,
                width: 2.0,
                color: Colors.blue,
              ),
              new Container(
                padding: EdgeInsets.only(bottom: 15.0, left: 20.0),
                height: 70.0,
                width: MediaQuery.of(context).size.width - 130,
                child: new TextField(
                  enabled: false,
                  decoration: null,
                  onChanged: null,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                  controller: new TextEditingController(
                      text: "Pickup will occur anywhere between 8 AM and 12PM." +
                          "you will recieve a more precise approximation on the day of Pickup and Delievery"),
                ),
              )
            ],
          )
        ],
      ),
    );

    bottomSheetController =
        currentPageKey.currentState.showBottomSheet((context) {
      return new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return new Container(
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            height: 260.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 5.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0))),
            child: new Column(
              //    mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    width: 50.0,
                    height: 10.0,
                    decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    )),
                _isSelectedContainerVisible
                    ? _selectedPickUpTimeContainer
                    : new Column(
                        children: <Widget>[
                          new SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _dayLabelController,
                            scrollDirection: Axis.horizontal,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Padding(
                                  child: new Text(
                                    "Today",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  padding: EdgeInsets.only(right: 180.0),
                                ),
                                new Padding(
                                  child: new Text(
                                    "Tommorow",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  padding: EdgeInsets.only(right: 160.0),
                                ),
                                new Padding(
                                  child: new Text(
                                    "Thursday",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  padding: EdgeInsets.only(right: 200.0),
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            height: 100.0,
                            child: new ListView(
                                controller: _dayIconController,
                                scrollDirection: Axis.horizontal,
                                addRepaintBoundaries: true,
                                children: new List.generate(12, (int index) {
                                  if (index % 4 == 3) {
                                    return new Container(
                                      margin: EdgeInsets.all(5.0),
                                      height: 50.0,
                                      width: 2.0,
                                      color: Colors.blue,
                                    );
                                  } else {
                                    return new CustomTime(
                                      index: index,
                                      isselected: _indexTimeList[index],
                                      callback: () async {
                                        var count = await MySharedPreferences
                                            .getPickUpTimeSelectedCount();
                                        if (count > 2) {
                                          for (int i = 0; i < 12; i++) {
                                            _indexTimeList[i] = false;
                                          }
                                          _indexTimeList[index] = true;
                                          setState(() {});
                                        } else {
                                          MySharedPreferences
                                              .setPickUpTimeSelectedCount(
                                                  ++count);
                                          _isSelectedContainerVisible = true;
                                          setState(() {});
                                        }
                                        debugPrint(
                                            _indexTimeList[index].toString());
                                      },
                                    );
                                  }
                                })),
                          ),
                        ],
                      ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: new RaisedButton(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            //  side: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25.0)),
                        color: Colors.white,
                        onPressed: () {},
                        child: new Text(
                          "UPDATE",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new RaisedButton(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            //  side: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(25.0)),
                        color: Colors.white,
                        onPressed: () {},
                        child: new Text(
                          "JUST ONCE",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
      });
    });
  }

  // _showNavigationList() {
  //   bottomSheetController = currentPageKey.currentState
  //       .showBottomSheet<Null>((BuildContext context) {
  //     return new Container(
  //         margin: EdgeInsets.only(top: 5.0),
  //         padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  //         width: MediaQuery.of(context).size.width,
  //         decoration: new BoxDecoration(
  //             color: Colors.white,
  //             boxShadow: [
  //               new BoxShadow(
  //                   blurRadius: 5.0,
  //                   //spreadRadius: 3.0,
  //                   color: Colors.grey)
  //             ],
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(8.0),
  //                 topRight: Radius.circular(8.0))),
  //         child: new Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             new Container(
  //                 margin: EdgeInsets.only(bottom: 20.0),
  //                 width: 50.0,
  //                 height: 10.0,
  //                 decoration: new BoxDecoration(
  //                   color: Colors.blue,
  //                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //                 )),

  //             _buildButton(() {
  //               bottomSheetController.close();
  //               callback(PageType.FREEWASH);
  //               _closeMainMenu();
  //             }, "Free Wash", new Icon(Icons.settings_backup_restore)),
  //             _buildButton(() {
  //               bottomSheetController.close();
  //               //callback(PageType.ACCOUNT);
  //               _showAccountSheet();
  //               _closeMainMenu();
  //             }, "Account", new Icon(Icons.person)),
  //             _buildButton(() {
  //               bottomSheetController.close();
  //               callback(PageType.CAREPREFRENCES);
  //               _closeMainMenu();
  //             }, "Care Preferences", new Icon(Icons.settings)),
  //             //_buildButton(() {
  //             //  callback(PageType.LAUNDRY);
  //             //}, "Laundry", new Icon(Icons.watch_later)),
  //             _buildButton(() {
  //               bottomSheetController.close();
  //               callback(PageType.WashOptions);
  //               _closeMainMenu();
  //             }, "Wash Options", new Icon(Icons.settings_applications)),
  //             _buildButton(() {
  //               bottomSheetController.close();
  //               callback(PageType.WashDetails);
  //               _closeMainMenu();
  //             }, "Wash Details ", new Icon(Icons.settings_bluetooth)),
  //             _buildButton(() {
  //               bottomSheetController.close();
  //               callback(PageType.WARDROBE);
  //               _closeMainMenu();
  //             }, "Wardrobe  ", new Icon(Icons.settings_applications)),
  //             new Container(
  //               padding: EdgeInsets.all(40.0),
  //             )
  //           ],
  //         ));
  //   });
  // }

//The Assistant
  _buildAssistant() {
    return new Container(
      decoration: !_isAsstLstVisible
          ? null
          : new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 10.0)
              ],
              color: Colors.transparent,
            ),
      width: MediaQuery.of(context).size.width,
      child:
          _isAsstLstVisible ? _buildAssistantList() : _buildAssistantButton(),
    );
  }

  _buildAssistantButton() {
    var _assistant = _buildCircleIcon(new IconButton(
        onPressed: () {
          _isAsstLstVisible = !_isAsstLstVisible;
          setState(() {});
        },
        icon: new Image.asset('assets/assistant_large.png')));
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(bottom: _assistantMargin),
          padding:
              EdgeInsets.only(top: 20.0, left: 05.0, right: 15.0, bottom: 05.0),
          child: _assistant,
          decoration: new BoxDecoration(
              shape: BoxShape.circle, color: Colors.transparent),
        ),
      ],
    );
  }

  bool _isAssistantClosed = true;

  _buildAssistantList() {
    var _assistant = !isVoiceAssistantVisible
        ? new Container()
        : new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            height: 40.0,
            width: 40.0,
            child: new Container(
              margin: EdgeInsets.all(2.5),
              height: 42.0,
              width: 42.0,
              child: _buildCircleIconBordered(new IconButton(
                  onPressed: () async {
                    // const url = 'https://assistant.google.com/services/invoke/uid/000000c3f81ac39a';
                    // if (await canLaunch(url)) {
                    //   await launch(url);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                    if (_isAssistantClosed) {
                      controller.forward();
                      _isAssistantClosed = false;
                    } else {
                      controller.reverse();
                      _isAssistantClosed = true;
                    }
                  },
                  icon: new Image.asset('assets/assistant_large.png'))),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  color: Colors.white),
            ),
            decoration: new BoxDecoration(

                //border: new Border.all(color: Colors.grey),
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 3.0,
                      spreadRadius: 3.0,
                      color: Colors.grey[400])
                ], shape: BoxShape.circle, color: Colors.white),
          );
    var _assistantOptions = new ListView(
      //  padding: EdgeInsets.only(left: 0.0, right: 10.0, bottom: 0.0),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        !isVoiceAssistantVisible
            ? new Container()
            : _buildCircleIcon(new IconButton(
                onPressed: () {
                  _isAsstLstVisible = !_isAsstLstVisible;
                  setState(() {});
                },
                icon: new Image.asset(
                  'assets/file_add.png',
                  color: !_isAssistantClosed ? Colors.black : Colors.grey[300],
                ))),
        !isVoiceAssistantVisible
            ? new Container()
            : _buildCircleIcon(new IconButton(
                onPressed: null, //!_isListening ? () => start() : null,
                icon: new Image.asset(
                  'assets/speaker.png',
                  color: !_isAssistantClosed ? Colors.black : Colors.grey[300],
                ))),
        !isVoiceAssistantVisible
            ? new Container()
            : _buildCircleIcon(new IconButton(
                onPressed: () {
                  if (!_isAssistantClosed) {
                    assistantPage.showHideMsgField();
                  }
                },
                icon: new Image.asset(
                  'assets/keyboard.png',
                  color: !_isAssistantClosed ? Colors.black : Colors.grey[300],
                ))),
        // _buildAssistantListButton(() {
        //   if (_isAssistantClosed) _showNavigationList();
        // },
        //     "PAGE NAVIGATION",
        //     new Icon(
        //       Icons.apps,
        //       color: _isAssistantClosed ? Colors.black : Colors.grey[300],
        //     )),
        _buildAssistantListButton(() {
          if (_isAssistantClosed) _showUserOptionItemSheet();
          setState(() {
            _isAsstLstVisible = !_isAsstLstVisible;
          });
        },
            "USER OPTIONS",
            new Icon(
              Icons.person,
              color: _isAssistantClosed ? Colors.black : Colors.grey[300],
            )),
        _buildAssistantListButton(() {
          if (_isAssistantClosed) _showAppOptionItemSheet();
          setState(() {
            _isAsstLstVisible = !_isAsstLstVisible;
          });
        },
            "APP OPTIONS",
            new Icon(
              Icons.phone_android,
              color: _isAssistantClosed ? Colors.black : Colors.grey[300],
            )),
        _buildAssistantListButton(() {
          if (_isAssistantClosed) _showItemSheet();
          setState(() {
            _isAsstLstVisible = !_isAsstLstVisible;
          });
        },
            "PAYMENT ISSUES",
            new Icon(
              Icons.monetization_on,
              color: _isAssistantClosed ? Colors.black : Colors.grey[300],
            )),
        _buildAssistantListButton(() {
          if (_isAssistantClosed) _showAddressChangeSheet();
          setState(() {
            _isAsstLstVisible = !_isAsstLstVisible;
          });
        },
            "ADDRESS CHANGE",
            new Icon(
              Icons.location_on,
              color: _isAssistantClosed ? Colors.black : Colors.grey[300],
            )),
        _buildAssistantListButton(() {
          if (_isAssistantClosed) _showTimeChangeSheet();
          setState(() {
            _isAsstLstVisible = !_isAsstLstVisible;
          });
        },
            "TIME CHANGE",
            new Icon(
              Icons.watch_later,
              color: _isAssistantClosed ? Colors.black : Colors.grey[300],
            )),
        // _buildAssistantListButton(() {
        //   if (_isAssistantClosed) _showImageChangeSheet();
        // },
        //     "IMAGE CHANGE",
        //     new Icon(
        //       Icons.watch_later,
        //       color: _isAssistantClosed ? Colors.black : Colors.grey[300],
        //     )),
      ],
    );

    return new Container(
      height: 65.0,
      color: Colors.white,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          !isSwipeFunctionAvailable
              ? new Container()
              : new Container(
                  margin: EdgeInsets.only(top: 2.0, bottom: 3.5),
                  width: 30.0,
                  height: 7.0,
                  decoration: new BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25.0)),
                  //  ),
                ),
          new Expanded(
            child: new Row(
              children: <Widget>[
                _assistant,
                new Expanded(
                  child: _assistantOptions,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  var pos;

  void _dragStart(DragStartDetails details) {
    // process the start by working with the details
    var tt = details.globalPosition;
    pos = tt.dy;
    // ...
  }

  void _dragEnd(DragUpdateDetails det) {
    if (det.globalPosition.dy > pos) {
      setState(() {
        _isAsstLstVisible = false;
      });
    }
  }

  var height;

  _buildTranslateWindow() {
    height = MediaQuery.of(context).size.height -
        animation.translateWindowAnimation.value;
    return new Transform.translate(
      offset: new Offset(0.0, height),
      child: assistantPage,
    );
  }

  _buildAssistantListButton(VoidCallback callback, String text, Widget icon) {
    var button = new FlatButton.icon(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(25.0)),
      onPressed: callback,
      textColor: _isAssistantClosed ? Colors.black : Colors.grey[300],
      label: new Text(text),
      icon: icon,
    );
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: new Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Container(
            height: 38.0,
            child: button,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(25.0)),
              boxShadow: [new BoxShadow(blurRadius: 5.0, color: Colors.grey)],
            ),
          ),
          Expanded(
            flex: 1,
            child: new Container(),
          ),
        ],
      ),
    );
  }

  _buildButton(VoidCallback callback, String text, Widget icon) {
    var button = new FlatButton.icon(
      shape: new RoundedRectangleBorder(
          //  side: BorderSide(color: Colors.grey),
          borderRadius: new BorderRadius.circular(30.0)),
      onPressed: callback,
      textColor: Colors.black,
      label: new Text(text),
      icon: icon,
    );
    return new Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: new Container(
          width: MediaQuery.of(context).size.width,
          child: button,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(25.0)),
            boxShadow: [new BoxShadow(blurRadius: 5.0, color: Colors.grey)],
          ),
        ));
  }

  _buildCircleIcon(Widget icon) {
    return new Container(
      // padding: EdgeInsets.all(2.0),
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      height: 38.0,
      width: 38.0,
      child: icon,
      decoration: new BoxDecoration(
          boxShadow: [new BoxShadow(blurRadius: 5.0, color: Colors.grey)],
          shape: BoxShape.circle,
          color: Colors.white),
    );
  }

  _buildCircleIconBordered(Widget icon) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      height: 38.0,
      width: 38.0,
      child: icon,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
          color: Colors.white),
    );
  }

  //Handle how back button will function

  var _exitApp = false;

  Future<bool> onWillPop(bool isAssistantVisible) async {
    if (_recentPages.length == 0) {
      // _setAssistantBottomMargin(PageType.WASHASSISTANTPAGE);
      // setState(() {});
      if (_exitApp) {
        exit(0);
      } else {
        currentPageKey.currentState.showSnackBar(new SnackBar(
          content: new Container(
            margin: EdgeInsets.only(bottom: isAssistantVisible ? 55.0 : 0.0),
            child: new Text("Press back again to exit the app"),
          ),
        ));
        _exitApp = true;
      }
      return false;
    } else {
      _exitApp = false;
      currentPage = _recentPages[_recentPages.length - 1].page;
      _setAssistantBottomMargin(_recentPages[_recentPages.length - 1].pageType);
      _recentPages.removeLast();
      setState(() {});

      return false;
    }
  }

  _setAssistantBottomMargin(PageType pageType) {
    switch (pageType) {
      case PageType.WARDROBE:
        _assistantMargin = GlobalVariables.assistantMagrginWardrobe;
        break;
      case PageType.ACCOUNT:
        _assistantMargin = GlobalVariables.assistantMagrginAccount;
        break;

      case PageType.WASHPAGE:
        _assistantMargin = 0.0;
        break;

      case PageType.NEWITEM:
        _assistantMargin = 0.0;
        break;

      default:
        _assistantMargin = GlobalVariables.assistantMagrginDefault;
    }
  }
}
