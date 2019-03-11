import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/giftwash/gift_slider_list.dart';
import 'package:wash_x/helpcentre/articles_details.dart';
import 'package:wash_x/helpcentre/build_a_case_slider.dart';
import 'package:wash_x/helpcentre/help_center_slider_list.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/articleTagModel.dart';
import 'package:wash_x/models/guideModel.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/linear_percent_indicator.dart';

class ReportABug extends StatefulWidget {
  @override
  _ReportABugState createState() => _ReportABugState();
}

class _ReportABugState extends State<ReportABug>
    with SingleTickerProviderStateMixin {

  List<ArticleTagModels> _items = <ArticleTagModels>[
    ArticleTagModels(
      articleTagTitle: 'MAPS',
      isSelected: false,
    ),
    ArticleTagModels(
      articleTagTitle: 'Navigation',
      isSelected: false,
    ),
    ArticleTagModels(
      articleTagTitle: 'Route',
      isSelected: false,
    ),
    ArticleTagModels(
      articleTagTitle: 'Wash',
      isSelected: false,
    ),
    ArticleTagModels(
      articleTagTitle: 'Password',
      isSelected: false,
    ),
    ArticleTagModels(
      articleTagTitle: 'Username',
      isSelected: false,
    ),
  ];

  static   List<GuideModels> _help_center_items = const <GuideModels>[
      GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "REPORT A BUG",
    ),
      GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "SEND FEEDBACK",
    ),
      GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "I NEED SUPPORT",
    ),
      GuideModels(
      guideImage: Icon(
        Icons.bug_report,
        color: Colors.black,
        size: 20.0,
      ),
      guideTitle: "I HAVE A PROBLEM",
    ),
  ];


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dHeight = (MediaQuery.of(context).size.height) * 0.9;





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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Container(
                  margin: EdgeInsets.only(top: 25.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11.0),
                              child: new Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.blueAccent),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                height: 4.0,
                                width: 18.0,
                              )),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7.0,
                                      top: 2.0,
                                      right: 2.0,
                                      bottom: 2.0),
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      top: 2.0,
                                      right: 8.0,
                                      bottom: 2.0),
                                  child: new Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.blueAccent),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0)),
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
                              border: Border.all(
                                  color: Colors.blueAccent, width: 2.0)),
                          alignment: Alignment.center)
                    ],
                  ),
                ),
              ),
              Container(
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
              ),
              Container(
                height: 140.0,
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: new Card(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 5.0),
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 5.0),
                            child: Text(
                              "HELP CENTER",
//                                    textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  fontSize: 12.0),
                            ),
                          ),
                          BuildCaseSliderList(
                            sliders: _items,
                          ),
                          Container(
                            child: Text(
                              "What is feedback about?",
//                                    textAlign: TextAlign.center,
                              style: new TextStyle(
                                  color: Colors.black45,
                                  fontSize: 11.0),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Container(
                height: 150.0,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildHomeView(),
          Container(
            height: 45.0,
            decoration: const BoxDecoration(
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
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                new Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 48.0,
                    child: Text(
                      "SUPPORT",
//                                    textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 10.0),
                    ),
                  ),
                ),
                InkResponse(
                  onTap: () {
                  },
                  child: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
