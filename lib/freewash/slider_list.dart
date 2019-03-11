import 'package:flutter/material.dart';
import 'package:wash_x/models/slider-model.dart';

//import 'package:washx/model/slider-model.dart';
import 'dart:async';

class SliderList extends StatelessWidget {
  final List<SliderModel> sliders;
  final TabController tabController;
  final double width;
  final double height;

  SliderList(
      {Key key, this.sliders, this.tabController, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: new Stack(
        children: <Widget>[
          new TabBarView(
            controller: tabController,
            children: sliders.map((SliderModel sliderModel) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: new GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      print("Drag Left - AddValue");
                    },
                    child: new Container(
                      padding: const EdgeInsets.all(10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Image.asset(
                                sliderModel.image,
                                fit: BoxFit.cover,
                                height: 48.0,
                                width: 48.0,
                              ),
                              new SizedBox(
                                width: 15.0,
                              ),
                              new Flexible(
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(sliderModel.title,
                                          softWrap: true,
                                          textDirection: TextDirection.ltr,
                                          style: new TextStyle(fontSize: 16.0)),
                                      width: 250.0,
                                    ),
                                    new SizedBox(
                                      height: 4.0,
                                    ),
                                    new Container(
                                      child: new Text(sliderModel.subTitle,
                                          softWrap: true,
                                          textDirection: TextDirection.ltr,
                                          style: new TextStyle(fontSize: 12.0)),
                                      width: 250.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          new InkWell(
                            onTap: () async {
                              _showDialog(context);
                            },
                            child: new Text(sliderModel.link,
                                style: new TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          new Positioned(
            bottom: 0.0,
            left: 120.0,
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
