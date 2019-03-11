import 'package:flutter/material.dart';
import 'package:wash_x/helpcentre/report_a_bug.dart';
import 'package:wash_x/models/articleTagModel.dart';

class BuildCaseSliderList extends StatelessWidget {
  final List<ArticleTagModels> sliders;

  BuildCaseSliderList(
      {Key key,
      @required this.sliders,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sliders.length,
            itemBuilder: (BuildContext contextM, int indexM) {

                return Container(
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
                          child: sliders[indexM].isSelected
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


                      /*    setState(() {
                            if (item.isSelected) {
                              item.isSelected = false;
                            } else {
                              item.isSelected = true;
                            }
                          });*/
                        },
                      ),
                      Text(
                        sliders[indexM].articleTagTitle,
                        style: TextStyle(fontSize: 11.0, color: Colors.black),
                      )
                    ],
                  ),
                );

            }));
  }
}
