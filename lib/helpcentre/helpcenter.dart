import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/giftwash/gift_slider_list.dart';
import 'package:wash_x/helpcentre/articles_details.dart';
import 'package:wash_x/helpcentre/articles_list.dart';
import 'package:wash_x/helpcentre/articles_slider_list.dart';
import 'package:wash_x/helpcentre/guide_slider_list.dart';
import 'package:wash_x/helpcentre/help_center_slider_list.dart';
import 'package:wash_x/helpcentre/homeAnimation.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/guideModel.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/linear_percent_indicator.dart';

class HelpCenter extends StatefulWidget {
  final Function callback;
  final RemoteConfig remoteConfig;

  HelpCenter(this.callback, this.remoteConfig);

  @override
  __HelpCenterState createState() => __HelpCenterState();
}

class __HelpCenterState extends State<HelpCenter>
    with SingleTickerProviderStateMixin {
  String strHelpCenterHome = "";

  static const List<ArticleModels> _items = const <ArticleModels>[
    const ArticleModels(
        articleTitle: 'How to change your password',
        articleMessage:
            'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
        isSeeAll: false),
    const ArticleModels(
        articleTitle: 'How to change your password',
        articleMessage:
            'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
        isSeeAll: false),
    const ArticleModels(
        articleTitle: 'How to change your password',
        articleMessage:
            'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
        isSeeAll: false),
    const ArticleModels(
        articleTitle: 'How to change your password',
        articleMessage:
            'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
        isSeeAll: false),
    const ArticleModels(
        articleTitle: 'SEE ALL', articleMessage: 'SEE ALL', isSeeAll: true),
  ];

  static const List<GuideModels> _guide_items = const <GuideModels>[
    const GuideModels(
      guideImage: Icon(
        Icons.search,
        size: 40.0,
      ),
      guideTitle: "SEARCH",
    ),
    const GuideModels(
      guideImage: Icon(
        Icons.blur_circular,
        size: 40.0,
      ),
      guideTitle: "GET ASSISTANS",
    ),
    const GuideModels(
      guideImage: Icon(
        Icons.touch_app,
        size: 40.0,
      ),
      guideTitle: "TAKE A TOURE",
    ),
  ];

  static const List<GuideModels> _help_center_items = const <GuideModels>[
    const GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "REPORT A BUG",
    ),
    const GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "SEND FEEDBACK",
    ),
    const GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "I NEED SUPPORT",
    ),
    const GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "I HAVE A PROBLEM",
    ),
  ];
  var animateStatus = 0;
  PersistentBottomSheetController bottomSheetController;
  final mSearchController = TextEditingController();
  AnimationController _buttonController;
  var gotoRoute;
  var articleDetails = ArticlesDetail();
  var articleList = ArticlesList();

  @override
  void initState() {
    getHelpCenterHome();
    super.initState();
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthProgress = (MediaQuery.of(context).size.width) * 0.9;
    double dHeight = (MediaQuery.of(context).size.height) * 0.9;

    List<Widget> helpCenterHomeList = new List<Widget>();

    //icon add
    helpCenterHomeList.add(Padding(
      padding: EdgeInsets.all(14.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        height: 110.0,
        width: 90.0,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11.0),
                    child: new Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.0, color: Colors.blueAccent),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      height: 4.0,
                      width: 18.0,
                    )),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                        padding: const EdgeInsets.only(
                            left: 7.0, top: 2.0, right: 2.0, bottom: 2.0),
                        child: new Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          height: 4.0,
                          width: 4.0,
                        )),
                    new Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: new Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          height: 4.0,
                          width: 4.0,
                        )),
                    new Padding(
                        padding: const EdgeInsets.only(
                            left: 2.0, top: 2.0, right: 8.0, bottom: 2.0),
                        child: new Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: Colors.blueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          height: 4.0,
                          width: 4.0,
                        )),
                  ],
                ),
              ],
            ),
            new Padding(padding: const EdgeInsets.symmetric(vertical: 10.0)),
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/ic_question.png",
                  width: 18.0,
                  height: 18.0,
                  color: Colors.blueAccent,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 2.0)),
                alignment: Alignment.center)
          ],
        ),
      ),
    ));

    if (strHelpCenterHome != null && strHelpCenterHome.isNotEmpty) {
      for (var item in json.decode(strHelpCenterHome)) {
        bool is_active = item[Constants.RES_IS_ACTIVE];
        int menu_id = item[Constants.RES_MENU_ID];
        String menu_title = item[Constants.RES_MENU_TITLE];
        if (is_active) {
          switch (menu_title) {
            case 'TIPS':
              helpCenterHomeList.add(Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: new Text(
                          menu_title,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.all(5.0),
                        height: 110.0,
                      ),
                    ],
                  ),
                )),
              ));
              break;

            case 'SEARCH':
              helpCenterHomeList.add(Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: new Card(
                    child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: new Text(
                          'SEARCH',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.all(5.0),
                        child: TextField(
                          onSubmitted: (String strValue) {
                            _showSearchResultSheet();
                          },
                          controller: mSearchController,
                          decoration: new InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12.0),
                            prefixIcon: new IconButton(
                              onPressed: null,
                              icon: new Icon(Icons.search),
                              color: Colors.black,
                            ),
                            labelText: "SEARCH",
                            labelStyle: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                            hintStyle: new TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey.withOpacity(0.1)),
                            border: new OutlineInputBorder(
                                gapPadding: 8.0,
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.grey, width: 10.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ));
              break;

            case 'ARTICLES':
              helpCenterHomeList.add(Container(
                height: 140.0,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: new Text(
                                  "ARTICLES",
//                                    textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 12.0),
                                )),
                          ),
                          Container(
                              child: InkWell(
                            child: new Text(
                              "SEE ALL",
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 11.0),
                            ),
                            onTap: () {
                              setState(() {
                                animateStatus = 1;
                                gotoRoute = articleList;
                              });
                              _playAnimation();
                            },
                          )),
                        ],
                      ),
                    ),
                    ArticlesSliderList(
                      sliders: _items,
                      width: widthProgress,
                      articleDetails: () {
                        setState(() {
                          animateStatus = 1;
                          gotoRoute = articleDetails;
                        });
                        _playAnimation();
                      },
                      articleList: () {
                        setState(() {
                          animateStatus = 1;
                          gotoRoute = articleList;
                        });
                        _playAnimation();
                        //print();
                      },
                    )
                  ],
                )),
              ));
              break;

            case 'GUIDE':
              helpCenterHomeList.add(Container(
                height: 140.0,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: new Card(
                    child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: new Text(
                                  "GUIDE",
//                                    textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 12.0),
                                )),
                          ),
                          Container(
                              child: InkWell(
                            child: new Text(
                              "SEE ALL",
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 11.0),
                            ),
                            onTap: () {
                              _showGuideSheet();
                            },
                          )),
                        ],
                      ),
                    ),
                    GuideSliderList(sliders: _guide_items)
                  ],
                )),
              ));
              break;

            case 'HELP CENTER':
              helpCenterHomeList.add(Container(
                height: 95.0,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: new Card(
                    child: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "HELP CENTER",
//                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                        fontSize: 12.0),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      HelpCenterSliderList(
                        sliders: _help_center_items,
                      )
                    ],
                  ),
                )),
              ));
              break;
          }
        }
      }
    }

    helpCenterHomeList.add(Container(
      height: 80.0,
    ));
    // Build Home View
    _buildHomeView() {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: dHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: helpCenterHomeList,
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: currentPageKey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          GestureDetector(
            child: _buildHomeView(),
            onTap: () {
              setState(() {
                print("TAP");
              });
            },

            /*  onTapUp: (TapUpDetails details) {
              setState(() {
                tapOffset = details.globalPosition;
              });
            },*/
          ),
          Container(
            height: 45.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            margin: EdgeInsets.only(top: 12.0),
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkResponse(
                  onTap: () {
                    this.widget.callback(PageType.WASHPAGE);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                new Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 48.0,
                    child: Text(
                      'HELP CENTER',
                      style: TextStyle(color: Colors.black, fontSize: 10.0),
                    ),
                  ),
                ),
                InkResponse(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          animateStatus == 0
              ? Container(
                  height: 0.0,
                )
              : new StaggerAnimation(
                  buttonController: _buttonController.view,
                  gotoRoute: gotoRoute,
                )
        ],
      ),
    );
  }

  final currentPageKey = new GlobalKey<ScaffoldState>();

  // Show Account Sheet Start
  _showSearchResultSheet() {
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

              Container(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: mSearchController,
                  decoration: new InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    prefixIcon: new IconButton(
                      onPressed: null,
                      icon: new Icon(Icons.search),
                      color: Colors.black,
                    ),
                    labelText: "SEARCH",
                    labelStyle: new TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    hintStyle: new TextStyle(
                        fontSize: 10.0, color: Colors.grey.withOpacity(0.1)),
                    border: new OutlineInputBorder(
                        gapPadding: 8.0,
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.grey, width: 10.0)),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 4.0)),
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

  // Guide Sheet
  _showGuideSheet() {
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

              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Welcome,",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "I'm your User Guide Think of me as your assistant's sidekick, i know where everthing is located so i can show you around and even take you places, just ask the assistant for somthing and i'll be there to guide you, you can aslo press and hold anywhere on app and it will be me that pops up to guide you.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 11.0, color: Colors.black),
                ),
              ),

              new SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                       Container(
                          height: 100.0,
                          width: 120.0,
                          margin: EdgeInsets.all(5.0),
                          child:new Card(
                            child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: new EdgeInsets.only(bottom: 8.0),
                                    alignment: Alignment.center,
                                    child: _guide_items[0].guideImage),
                                Container(
                                    alignment: Alignment.center,
                                    child: new Text(
                                      _guide_items[0].guideTitle,
                                      textAlign: TextAlign.justify,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                          fontSize: 11.0),
                                    )),
                              ],
                            ),
                            onTap: () {},
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      Container(
                          height: 100.0,
                          width: 120.0,
                          margin: EdgeInsets.all(5.0),
                          child:new Card(
                            child:  InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: new EdgeInsets.only(bottom: 8.0),
                                    alignment: Alignment.center,
                                    child: _guide_items[1].guideImage),
                                Container(
                                    alignment: Alignment.center,
                                    child: new Text(
                                      _guide_items[1].guideTitle,
                                      textAlign: TextAlign.justify,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                          fontSize: 11.0),
                                    )),
                              ],
                            ),
                            onTap: () {},
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      ),
                      Container(
                        height: 100.0,
                        width: 120.0,
                        margin: EdgeInsets.all(5.0),
                                             child: new Card(
                          child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: new EdgeInsets.only(bottom: 8.0),
                                    alignment: Alignment.center,
                                    child: _guide_items[2].guideImage),
                                Container(
                                    alignment: Alignment.center,
                                    child: new Text(
                                      _guide_items[2].guideTitle,
                                      textAlign: TextAlign.justify,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey,
                                          fontSize: 11.0),
                                    )),
                              ],
                            ),
                            onTap: () {},
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                      )
                    ],
                  )),
              Padding(padding: EdgeInsets.only(top: 4.0)),
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

  getHelpCenterHome() {
    strHelpCenterHome =
        widget.remoteConfig.getString(Constants.firebaseHelpCenterHome);
  }

  Future<Null> _playAnimation() async {
    try {
      _buttonController.addListener(() {
        if (_buttonController.isCompleted) {
          startTime();
        }
      });
      await _buttonController.forward();
      await _buttonController.reverse();
    } on TickerCanceled {}
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, startAnim);
  }

  void startAnim() {
    setState(() {
      animateStatus = 0;
    });
  }
}
