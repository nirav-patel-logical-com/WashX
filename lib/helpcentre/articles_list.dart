import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/giftwash/gift_slider_list.dart';
import 'package:wash_x/helpcentre/articles_details.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/articleTagModel.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:wash_x/pages/mainPage.dart';
import 'package:wash_x/widgets/linear_percent_indicator.dart';

class ArticlesList extends StatefulWidget {
  @override
  __ArticlesState createState() => __ArticlesState();
}

class __ArticlesState extends State<ArticlesList>
    with SingleTickerProviderStateMixin {
  bool _isActiveWashVisible = false;
  PersistentBottomSheetController bottomSheetController;

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
    List<Widget> _itemsSelected = new List<Widget>();

    if (bottomSheetController != null) {
      bottomSheetController.closed.whenComplete(() {
        setState(() {});
      });
    }
    for (ArticleTagModels item in _items) {
      if (item.isSelected) {
        _itemsSelected.add(Container(
          height: 30.0,
          margin: EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 25.0, right: 15.0),
                    child: new Text(
                      item.articleTagTitle,
                      textAlign: TextAlign.justify,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 11.0),
                    )),
                InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(2.0),
                      margin: EdgeInsets.only(right: 10.0),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.clear,
                        color: Colors.blueAccent.withOpacity(0.7),
                        size: 15.0,
                      )),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  onTap: () {
                    setState(() {
                      item.isSelected = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
      }
    }

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
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.question_answer,
                              size: 30.0,
                              color: Colors.black,
                            ),
                            margin: EdgeInsets.only(right: 15.0),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      padding: new EdgeInsets.only(bottom: 8.0),
                                      alignment: Alignment.topLeft,
                                      child: new Text(
                                        "FAQ",
//                                    textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      )),
                                  Container(
                                      padding: new EdgeInsets.only(right: 2.0),
                                      child: new Text(
                                        "You ask we answer, here are the most asked quations that have been asked from support team",
                                        textAlign: TextAlign.justify,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                            fontSize: 11.0),
                                      )),
                                ],
                              ))
                        ],
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                  child: InkWell(
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
                                'How to change your password',
//                                    textAlign: TextAlign.center,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 15.0),
                              )),
                          Container(
                              padding: new EdgeInsets.only(right: 2.0),
                              child: new Text(
                                'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 11.0),
                              )),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesDetail()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                  child: InkWell(
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
                                'How to change your password',
//                                    textAlign: TextAlign.center,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 15.0),
                              )),
                          Container(
                              padding: new EdgeInsets.only(right: 2.0),
                              child: new Text(
                                'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 11.0),
                              )),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesDetail()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                  child: InkWell(
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
                                'How to change your password',
//                                    textAlign: TextAlign.center,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 15.0),
                              )),
                          Container(
                              padding: new EdgeInsets.only(right: 2.0),
                              child: new Text(
                                'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 11.0),
                              )),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesDetail()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                  child: InkWell(
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
                                'How to change your password',
//                                    textAlign: TextAlign.center,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 15.0),
                              )),
                          Container(
                              padding: new EdgeInsets.only(right: 2.0),
                              child: new Text(
                                'When you change your password make sure you have the old on ready so you can change before if is disregarded...',
                                textAlign: TextAlign.justify,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 11.0),
                              )),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlesDetail()),
                      );
                    },
                  ),
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
      key: currentPageKey,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildHomeView(),
          Container(
            alignment: Alignment.topLeft,
            height: _itemsSelected != null && _itemsSelected.isNotEmpty
                ? 90.0
                : 0.0,
            child: new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _itemsSelected,
              ),
            ),
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
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                new Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 48.0,
                    child: Text(
                      "ARTICLES",
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
                    _showArticlesTopicSheet();
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

  final currentPageKey = new GlobalKey<ScaffoldState>();

  // Guide Sheet
  _showArticlesTopicSheet() {
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
        child: SelectArticleTag(
          items: _items,
        ),
      );
    });
  }
}

class SelectArticleTag extends StatefulWidget {
  List<ArticleTagModels> items;

  SelectArticleTag({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  _CustomTimeState createState() => new _CustomTimeState();
}

class _CustomTimeState extends State<SelectArticleTag> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _itemsNotSelected = new List<Widget>();
    for (ArticleTagModels item in widget.items) {
      _itemsNotSelected.add(Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            InkWell(
              child: Container(
                margin: EdgeInsets.only(bottom: 5.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    //    border: Border.all(color: Colors.transparent),
                    boxShadow: [
                      new BoxShadow(
                          blurRadius: 4.0,
                          //spreadRadius: 3.0,
                          color: Colors.grey)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                height: 30.0,
                width: 30.0,
                child: item.isSelected
                    ? Icon(
                  Icons.done,
                  color: Colors.blueAccent,
                  size: 27.0,
                )
                    : Container(
                  height: 0.0,
                  width: 0.0,
                ),
              ),
              onTap: () {
                setState(() {
                  if (item.isSelected) {
                    item.isSelected = false;
                  } else {
                    item.isSelected = true;
                  }
                });
              },
            ),
            Text(
              item.articleTagTitle,
              style: TextStyle(fontSize: 11.0, color: Colors.black),
            )
          ],
        ),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
          new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _itemsNotSelected,
              )),
          Padding(padding: EdgeInsets.only(top: 4.0)),
          Container(
            height: 40.0,
          )
          //new UserOptions(remoteConfig: widget.remoteConfig,)
        ],
      ),
    );
  }
}
