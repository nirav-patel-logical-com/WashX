import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/giftwash/gift_slider_list.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/linear_percent_indicator.dart';

class ArticlesDetail extends StatefulWidget {
  @override
  __ArticlesState createState() => __ArticlesState();
}

class __ArticlesState extends State<ArticlesDetail>
    with SingleTickerProviderStateMixin {
  bool _isActiveWashVisible = false;

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
    double widthProgress = (MediaQuery.of(context).size.width) * 0.9;
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
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: new EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'Where can I change the push notification settings?',
//                                    textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15.0),
                          )),
                      Container(
                          padding: new EdgeInsets.only(right: 2.0),
                          child: new Text(
                            'Open the app and open Profile/Push & Approval. Here you can adjust the settings as you wish.',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                    ],
                  ),
                )),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: new EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'What prerequisites need to be fulfilled so that I can use CONNECTED WASH?',
//                                    textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15.0),
                          )),
                      Container(
                          padding: new EdgeInsets.only(right: 2.0),
                          child: new Text(
                            'To connect a CONNECTED WASH machine to your network without any issues, there are a few prerequisites that need to be fulfilled.',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                    ],
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: new EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'How many entries are saved in the wash cycle diary?',
//                                    textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15.0),
                          )),
                      Container(
                          padding: new EdgeInsets.only(right: 2.0),
                          child: new Text(
                            'The number of entries is unlimited. So that you can always maintain an overview, you can filter which time periods are shown.',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                    ],
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: new EdgeInsets.only(bottom: 10.0),
                          alignment: Alignment.topLeft,
                          child: new Text(
                            'I wash several times a day, but the app does not count the wash cycles. What is the reason?',
//                                    textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15.0),
                          )),
                      Container(
                          padding: new EdgeInsets.only(right: 2.0),
                          child: new Text(
                            'If the current date and time are set incorrectly, the wash cycles in the background are counted, but they do not appear in the overview.',
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                    ],
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "ACTIONS",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 12.0),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          child: Card(),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          height: 100.0,
                          width: 100.0,
                          child: Card(),
                        ),
                        Container(
                          height: 100.0,
                          width: 100.0,
                          child: Card(),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "AUTHOR",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 12.0),
                      ),
                    ),
                   Container(
                     margin: EdgeInsets.only(top: 12.0,left: 12.0),
                     child:  Row(
                       children: <Widget>[
                         CircleAvatar(
                           backgroundImage: new NetworkImage(
                               'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg'),
                           radius: 20.0,
                         ),
                         Container(
                             padding:
                             new EdgeInsets.only(left: 10.0),
                             child: new Text(
                               "Mendy Marcus",
//                                    textAlign: TextAlign.center,
                               style: new TextStyle(
                                   fontWeight: FontWeight.w300,
                                   color: Colors.blueAccent,
                                   fontSize: 12.0),
                             )),
                       ],
                     ),
                   )
                  ],
                ),
              ),Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "TAGS",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 12.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0,left: 12.0),
                      child:  Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 15.0,right: 15.0),
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.grey[350],
                                )),
                            child: InkWell(
                              child:  Container(
                                  alignment: Alignment.center,
                                  child: new Text(
                                    "MAPS",
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 10.0),
                                  )),
                              onTap: () {},
                              borderRadius:
                              BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 15.0,right: 15.0),
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.grey[350],
                                )),
                            child: InkWell(
                              child:  Container(
                                  alignment: Alignment.center,
                                  child: new Text(
                                    "MAPS",
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 10.0),
                                  )),
                              onTap: () {},
                              borderRadius:
                              BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.only(top: 3.0,bottom: 3.0,left: 15.0,right: 15.0),
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.grey[350],
                                )),
                            child: InkWell(
                              child:  Container(
                                  alignment: Alignment.center,
                                  child: new Text(
                                    "MAPS",
                                    textAlign: TextAlign.justify,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 10.0),
                                  )),
                              onTap: () {},
                              borderRadius:
                              BorderRadius.all(Radius.circular(25.0)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "WASH THIS HELPFULL?",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            fontSize: 12.0),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12.0,left: 12.0),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {},
                            child: new Text(
                              "YES",
                              style:
                              TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                            ),
                            color: Colors.white,
                            shape: StadiumBorder(
                              // side: BorderSide(color: Colors.grey[300], width: 2.0)
                            ),
                          ),Padding(padding: EdgeInsets.only(left: 15.0)),RaisedButton(
                            onPressed: () {},
                            child: new Text(
                              "NO",
                              style:
                              TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                            ),
                            color: Colors.white,
                            shape: StadiumBorder(
                              // side: BorderSide(color: Colors.grey[300], width: 2.0)
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60.0,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Icon(
            Icons.question_answer,
            size: 34.0,
            color: Colors.black,
          ),
        ),
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildHomeView(),
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
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                new Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 48.0,
                    child: Text(
                      'ARTICLES',
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
        ],
      ),
    );
  }
}
