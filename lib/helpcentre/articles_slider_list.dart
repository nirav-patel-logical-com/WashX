import 'package:flutter/material.dart';
import 'package:wash_x/helpcentre/articles_details.dart';
import 'package:wash_x/helpcentre/articles_list.dart';
import 'package:wash_x/models/articleModel.dart';

//import 'package:washx/model/slider-model.dart';
import 'dart:async';

class ArticlesSliderList extends StatelessWidget {
  final List<ArticleModels> sliders;
  final double width;
  final articleDetails;
  final articleList;

  ArticlesSliderList(
      {Key key,
      @required this.sliders,
      @required this.width,
      this.articleDetails,
      this.articleList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sliders.length,
            itemBuilder: (BuildContext contextM, int indexM) {
              if (sliders[indexM].isSeeAll) {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.grey[350],
                      )),
                  width: 120.0,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, right: 12.0, left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: new EdgeInsets.only(bottom: 10.0),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 30.0,
                              )),
                          Container(
                              child: new Text(
                            sliders[indexM].articleMessage,
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                        ],
                      ),
                    ),
                    onTap: articleList,
                  ),
                );
              } else {
                return Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.grey[350],
                      )),
                  width: width * 0.7,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, right: 12.0, left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: new EdgeInsets.only(bottom: 8.0),
                              alignment: Alignment.topLeft,
                              child: new Text(
                                sliders[indexM].articleTitle,
//                                    textAlign: TextAlign.center,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 12.0),
                              )),
                          Container(
                              child: new Text(
                            sliders[indexM].articleMessage,
                            textAlign: TextAlign.justify,
                            style: new TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                fontSize: 11.0),
                          )),
                        ],
                      ),
                    ),
                    onTap: articleDetails,


                  ),
                );
              }
            }));
  }

  Future<Null> _showDialog(BuildContext context) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('WashX'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Text here...'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
