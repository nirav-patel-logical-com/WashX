import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/viewModels/WardrobeModel.dart';

class NewWashItemCapture extends StatelessWidget {
  final WardrobeModel itemModel;
  final PersistentBottomSheetController bottomSheetController;

  NewWashItemCapture(this.itemModel, this.bottomSheetController);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
      model: itemModel,
      child: ScopedModelDescendant<WardrobeModel>(
          builder: (context, child, model) {
        return new Column(
          children: <Widget>[
            new Container(
              height: model.captureBottomSheetSize,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ScopedModelDescendant<WardrobeModel>(
                    builder: (context, child, model) {
                      String data = model.topCaptureLabel;
                      if (data.isNotEmpty || data != null) {
                        return new Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 10.0),
                          child: new Text(
                            data,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      } else {
                        return new Container();
                      }
                    },
                  ),
                  new Expanded(
                    child: _buildBottom(),
                  ),
                  ScopedModelDescendant<WardrobeModel>(
                    builder: (context, child, model) {
                      if (model.nextCaptureButtonLabel.isNotEmpty ||
                          model.bottomCaptureDescription.isNotEmpty) {
                        return new Container(
                          height: 50.0,
                          padding: EdgeInsets.only(left: 10.0),
                          alignment: Alignment.center,
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: model.bottomDescription.isEmpty
                                    ? new Container()
                                    : Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 43.0),
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: new Text.rich(
                                          new TextSpan(
                                            text:
                                                model.bottomCaptureDescription,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11.0),
                                          ),
                                        )),
                              ),
                              model.nextCaptureButtonLabel.isEmpty
                                  ? new Container()
                                  : new Center(
                                      child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.0, right: 5.0),
                                      child: RaisedButton(
                                        shape: StadiumBorder(),
                                        color: Colors.white,
                                        onPressed: () {
                                          if (model.captureStep == 3) {
                                            bottomSheetController.close();
                                          }
                                          model.onCaptureItemBtnClicked();
                                        },

                                        //  onPressed: model.increaseCaptureCount,
                                        child: new Text(
                                          model.nextCaptureButtonLabel,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                            ],
                          ),
                        );
                      } else {
                        return new Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  _buildBottom() {
    return ScopedModelDescendant<WardrobeModel>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        if (model.captureStep == 1) {
          return Container(
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      height: 70.0,
                      width: 70.0,
                      child: new IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                          size: 50.0,
                        ),
                        onPressed: () {
                          itemModel.changeCameraType(CameraType.PHOTO);
                          itemModel.changeCameraVisibility(true);
                        },
                      ),
                      decoration: BoxDecoration(
                          color: model.itemImagePath == null ||
                                  model.itemImagePath.isEmpty
                              ? Colors.white
                              : Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                                blurRadius: 1.5,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 2.0),
                                color: Colors.grey[350])
                          ]),
                    ),
                    new Text(
                      "PHOTO",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      height: 70.0,
                      width: 70.0,
                      child: new IconButton(
                          icon: Icon(
                            Icons.loyalty,
                            size: 50.0,
                          ),
                          onPressed: () {
                            itemModel.changeCameraType(CameraType.LABEL);
                            itemModel.changeCameraVisibility(true);
                          }),
                      decoration: BoxDecoration(
                          color: model.labelImagePath == null ||
                                  model.labelImagePath.isEmpty
                              ? Colors.white
                              : Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                                blurRadius: 1.5,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 2.0),
                                color: Colors.grey[350])
                          ]),
                    ),
                    new Text(
                      "LABEL",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      height: 70.0,
                      width: 70.0,
                      child: new IconButton(
                          icon: Icon(
                            Icons.blur_linear,
                            size: 50.0,
                          ),
                          onPressed: () {
                            itemModel.changeCameraType(CameraType.BARCODE);
                            itemModel.changeCameraVisibility(true);
                          }),
                      decoration: BoxDecoration(
                          color: model.barcodeImagePath == null ||
                                  model.barcodeImagePath.isEmpty
                              ? Colors.white
                              : Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            new BoxShadow(
                                blurRadius: 1.5,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 2.0),
                                color: Colors.grey[350])
                          ]),
                    ),
                    new Text(
                      "BARCODE",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          );
        } else if (model.captureStep == 2) {
          debugPrint("hello 2");
          return Center(
            child: SingleChildScrollView(
              physics: model.isBottomSheetExpanded
                  ? PageScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 2.0,
                            offset: Offset(1.0, 2.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "NAME",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        !model.isMatchFound
                            ? new Container(
                                height: 50.0,
                              )
                            : new Text(
                                "Daisy Dress",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w300),
                              )
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 2.0,
                            offset: Offset(1.0, 2.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "BRAND",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        !model.isMatchFound
                            ? new Container(
                                height: 50.0,
                              )
                            : new FlatButton.icon(
                                color: Colors.white,
                                icon: Icon(Icons.alarm),
                                label: new Text(
                                  "Adidas",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                onPressed: () {},
                              )
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 2.0,
                            offset: Offset(1.0, 2.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "CATEGORIES",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        !model.isMatchFound
                            ? new Container(
                                height: 50.0,
                              )
                            : new Row(
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        new BoxShadow(
                                            blurRadius: 1.0,
                                            spreadRadius: 1.5,
                                            offset: Offset(1.0, 2.0),
                                            color: Colors.grey[350])
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: new Text("T-Shirt"),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 10.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        new BoxShadow(
                                            blurRadius: 1.0,
                                            spreadRadius: 1.5,
                                            offset: Offset(1.0, 2.0),
                                            color: Colors.grey[350])
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: new Text("Winter"),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 2.0,
                            offset: Offset(1.0, 2.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "COLORS",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        !model.isMatchFound
                            ? new Container(
                                height: 50.0,
                              )
                            : new Row(
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 10.0),
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange,
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width - 40.0,
                    margin: EdgeInsets.all(5.0),
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                            blurRadius: 1.5,
                            spreadRadius: 2.0,
                            offset: Offset(1.0, 2.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "CARE",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        !model.isMatchFound
                            ? new Container(
                                height: 50.0,
                              )
                            : new Row(
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey[350],
                                          blurRadius: 1.5,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      color: Colors.blue,
                                    ),
                                    // child: new Icon(Icons.watch_later),
                                  ),
                                  new Container(
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 10.0),
                                    width: 60.0,
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey[350],
                                          blurRadius: 1.5,
                                          spreadRadius: 2.0,
                                        ),
                                      ],
                                      color: Colors.blue,
                                    ),
                                    //child: new Icon(Icons.watch_later),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return new Center(
            child: new Text(
              "Item Imported Successfully",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}
