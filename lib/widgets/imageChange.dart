import 'package:flutter/material.dart';
import 'package:wash_x/custom/customImageChange.dart';
import 'package:wash_x/models/washItem.dart';
import 'package:wash_x/viewModels/WardrobeModel.dart';

class ImageChange extends StatefulWidget {
  final WashItem item;
  final WardrobeModel model;
  ImageChange(this.item, this.model);
  @override
  _ImageChangeState createState() => new _ImageChangeState();
}

class _ImageChangeState extends State<ImageChange> {
  @override
  Widget build(BuildContext context) {
    var _lengthYour = widget.model.yourPhotosList.length;
    var _lengthSystem = widget.model.systemPhotosList.length;
    var _lengthTotal = _lengthSystem + _lengthYour;

    ScrollController _timeLabelController = new ScrollController();
    ScrollController _timeIconController = new ScrollController();

    _timeIconController.addListener(() {
      if (_timeIconController.offset >= (_lengthYour + 1) * 150.0 + 20.0) {
        _timeLabelController.animateTo((_lengthYour + 2) * 150.0 - 40.0,
            curve: Curves.ease, duration: Duration(milliseconds: 100));
      } else {
        _timeLabelController.animateTo(0.0,
            curve: Curves.ease, duration: Duration(milliseconds: 100));
      }
    });
    return new Container(
        margin: EdgeInsets.only(top: 5.0),
        padding: EdgeInsets.only(
          top: 5.0,
          //bottom: 40.0,
          left: 5.0,
        ),
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        decoration: new BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                  blurRadius: 5.0,
                  //spreadRadius: 3.0,
                  color: Colors.grey)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
        child: new Column(
          //    mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
                width: 50.0,
                height: 10.0,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                )),
            new Column(
              children: <Widget>[
                new SingleChildScrollView(
                  //   physics: NeverScrollableScrollPhysics(),
                  controller: _timeLabelController,
                  scrollDirection: Axis.horizontal,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Padding(
                        child: new Text(
                          "YOUR PHOTOS",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(
                            right: ((_lengthYour + 1) * 150.0 + 20.0)),
                      ),
                      new Padding(
                        child: new Text(
                          "SYSTEM PHOTOS",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width),
                      ),
                    ],
                  ),
                ),
                new Container(
                  height: 170.0,
                  child: new ListView(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      controller: _timeIconController,
                      scrollDirection: Axis.horizontal,
                      addRepaintBoundaries: true,
                      children:
                          new List.generate(_lengthTotal + 3, (int index) {
                        if (index == 0) {
                          return new Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1.5,
                                      spreadRadius: 2.0,
                                      color: Colors.grey[300])
                                ]),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.camera_alt,
                                  size: 100.0,
                                ),
                                new Text(
                                  "CAPTURE",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }
                        if (index == widget.model.yourPhotosList.length + 2 ||
                            index == 1) {
                          return new Container(
                            //margin: EdgeInsets.symmetric(vertical:5.0,horizontal: 10.0),
                            margin: EdgeInsets.only(
                                bottom: 10.0,
                                left: 10.0,
                                right: 0.0,
                                top: 10.0),
                            height: 50.0,
                            width: 2.0,
                            color: Colors.blue,
                          );
                        } else {
                          if (index >= _lengthYour + 3) {
                            var item = widget.model
                                .systemPhotosList[index - (_lengthYour + 3)];
                            return new CustomImage(
                              index: index,
                              isselected: item.isSelected,
                              photo: item.icon,
                              callback: () {
                                widget
                                        .model
                                        .systemPhotosList[index - (_lengthYour + 3)]
                                        .isSelected =
                                    !widget
                                        .model
                                        .systemPhotosList[
                                            index - (_lengthYour + 3)]
                                        .isSelected;

                                setState(() {});
                              },
                            );
                          } else {
                            debugPrint(_lengthYour.toString() +
                                _lengthSystem.toString());
                            var item = widget.model.yourPhotosList[index - 2];
                            return new CustomImage(
                              index: index,
                              photo: item.icon,
                              isselected: item.isSelected,
                              callback: () {
                                widget.model.yourPhotosList[index - 2]
                                        .isSelected =
                                    !widget.model.yourPhotosList[index - 2]
                                        .isSelected;
                                setState(() {});
                              },
                            );
                          }
                        }
                      })),
                ),
              ],
            ),
          ],
        ));
  }
}
