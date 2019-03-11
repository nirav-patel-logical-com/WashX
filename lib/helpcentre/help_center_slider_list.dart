import 'package:flutter/material.dart';
import 'package:wash_x/helpcentre/report_a_bug.dart';
import 'package:wash_x/models/articleModel.dart';
import 'package:wash_x/models/guideModel.dart';
import 'package:wash_x/models/slider-model.dart';

//import 'package:washx/model/slider-model.dart';
import 'dart:async';

class HelpCenterSliderList extends StatelessWidget {
  final List<GuideModels> sliders;
  HelpCenterSliderList({Key key, @required this.sliders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sliders.length,
            itemBuilder: (BuildContext contextM, int indexM) {
              return  Container(
                margin: EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 3.0,bottom: 3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[350])),
                            padding: EdgeInsets.all(2.0),
                            margin: EdgeInsets.only(left: 4.0),
                            alignment: Alignment.center,
                            child: sliders[indexM].guideImage),
                        Container(
                            margin: EdgeInsets.only(
                                left: 30.0, right: 30.0),
                            child: new Text(
                              sliders[indexM].guideTitle,
                              textAlign: TextAlign.justify,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 11.0),
                            )),
                      ],
                    ),
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(30.0)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportABug()),
                    );
                    //ReportABug
                  },
                ),
              );
            }));
  }

}
