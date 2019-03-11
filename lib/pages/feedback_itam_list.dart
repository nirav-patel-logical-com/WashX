import 'package:flutter/material.dart';
import 'package:wash_x/models/feedback-model.dart';
import 'package:wash_x/models/slider-model.dart';

//import 'package:washx/model/slider-model.dart';
import 'dart:async';

class FeedBackItemList extends StatelessWidget {
  final List<FeedbackModel> sliders;
  final TabController tabController;
  final double width;
  final double height;

  FeedBackItemList(
      {Key key, this.sliders, this.tabController, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new TabBarView(
            controller: tabController,
            children: sliders.map((FeedbackModel feedbackModel) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: new ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: new Container(
                      padding: EdgeInsets.all(10.0),
                      child: new GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          print("Drag Left - AddValue");
                        },
                        child: new ListView(
                          children: <Widget>[
                            Card(
                              elevation: 5.0,
                              margin: new EdgeInsets.all(5.0),
                              child: Container(
                                height: 88.0,
                              ),
                            ),
                            Card(
                                elevation: 5.0,
                                margin: new EdgeInsets.all(5.0),
                                child: Container(
                                  height: 88.0,
                                )),
                            Card(
                                elevation: 5.0,
                                margin: new EdgeInsets.all(5.0),
                                child: Container(
                                  height: 88.0,
                                )),
                          ],
                        ),
                      ),
                    )
                    /*  child: new GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      print("Drag Left - AddValue");
                    },
                  ),*/
                    ),
              );
            }).toList(),
          ),
          new Positioned(
            bottom: 0.0,
            height: 40.0,
            child: new PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child: Theme(
                data: Theme.of(context).copyWith(
                      accentColor: Colors.grey.withOpacity(0.4),
                    ),
                child: Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: TabPageSelector(
                    controller: tabController,
                    color: Colors.grey.withOpacity((0.4)),
                    selectedColor: Colors.grey,
                    indicatorSize: 8.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      height: height,
      width: width,
    );
  }

  void _nextPage(int delta) {
    final int newIndex = tabController.index + delta;
    if (newIndex < 0 || newIndex >= tabController.length) return;
    tabController.animateTo(newIndex);
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
