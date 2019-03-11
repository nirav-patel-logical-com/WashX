import 'package:flutter/material.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/guideModel.dart';
import 'package:wash_x/models/slider-model.dart';

//import 'package:washx/model/slider-model.dart';
import 'dart:async';

class GuideSliderList extends StatelessWidget {
  final List<GuideModels> sliders;
  GuideSliderList({Key key, @required this.sliders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sliders.length,

            itemBuilder: (BuildContext contextM, int indexM) {
              return  Container(
                width: 120.0,
                margin: EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),
                child: InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: new EdgeInsets.only(bottom: 8.0),
                          alignment: Alignment.center,
                          child: sliders[indexM].guideImage),
                      Container(
                          alignment: Alignment.center,
                          child: new Text(
                            sliders[indexM].guideTitle,
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
              );
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
