import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

class SetupScreenWidgets {
  static messageBox(String message, AnimationController controller) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        child: new Container(
          decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  blurRadius: 0.5,
                  spreadRadius: 1.0,
                  color: Colors.grey,
                )
              ],
              color: Colors.white,
              //  border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
          margin: const EdgeInsets.only(
              left: 3.0, top: 2.0, bottom: 2.0, right: 2.0),
          child: new Text(
            message,
            style: TextStyle(fontSize: 11.0),
          ),
        ));
  }

  static messageBoxReverse(String message, AnimationController controller) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        child: new Container(
          alignment: AlignmentDirectional.centerEnd,
          margin: const EdgeInsets.symmetric(vertical: 2.5),
          padding: EdgeInsets.only(right: 2.0, left: 2.0),
          child: new Container(
            padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
            decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    blurRadius: 0.5,
                    spreadRadius: 1.0,
                    color: Colors.grey,
                  )
                ],
                color: Colors.white,
                // border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: new Text(
              message,
              style: TextStyle(fontSize: 11.0),
            ),
          ),
        ));
  }

  static messageBoxLarge(String message, AnimationController controller) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        axisAlignment: 0.0,
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          child: new Text(
            message,
            style: TextStyle(fontSize: 17.0),
          ),
        ));
  }

  static messageBoxLargeUnanimated(String message) {
    return new Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        child: new Text(
          message,
          style: TextStyle(fontSize: 17.0),
        ));
  }

  static textField(AnimationController controller) {
    return new SizeTransition(
        sizeFactor:
            new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        child: new Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          child: new TextField(
            decoration: new InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              prefixIcon: new IconButton(
                onPressed: null,
                icon: new Icon(Icons.blur_circular),
                color: Colors.black,
              ),
              hintStyle: new TextStyle(fontSize: 10.0, color: Colors.grey),
              border: new OutlineInputBorder(
                  gapPadding: 8.0,
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: new BorderSide(color: Colors.grey, width: 10.0)),
            ),
          ),
        ));
  }

  static imageBox(AnimationController controller, String asset) {
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      child: new Container(
          height: 150.0,
          alignment: AlignmentDirectional.center,
          child: new GestureDetector(
            child: new Container(
              padding: EdgeInsets.all(20.0),
              child: new CircleAvatar(
                  backgroundImage: AssetImage(asset),
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  child: new Container(
                    decoration: new BoxDecoration(
                        border: Border.all(color: Colors.grey[200], width: 1.0),
                        borderRadius: BorderRadius.circular(50.0)),
                  )),
            ),
          )),
    );
  }
}

class ListPayments extends StatefulWidget {
  final AnimationController controller;
  ListPayments(this.controller);
  @override
  _ListPaymentsState createState() => new _ListPaymentsState(controller);
}

class _ListPaymentsState extends State<ListPayments> {
  _ListPaymentsState(this.controller);
  AnimationController controller;
  List<Widget> payments = <Widget>[];

  @override
  void initState() {
    super.initState();
    payments.insert(
        0,
        _createPaymentButton(
            () async => await _bottomSheetAddPayment(),
            "ADD",
            new Icon(
              Icons.add,
              color: Colors.blue,
            )));
  }

  var _isGPayAdded = false;
  Future<bool> _onAddPaymentBtnClicked() async {
    if (_isGPayAdded) {
      return false;
    }
    _isGPayAdded = true;
    payments.insert(
        0,
        _createPaymentButton(
            () async => await _onGPayBtnClicked(),
            "Pay",
            new Icon(
              Icons.assistant,
              color: Colors.blue,
            )));
    setState(() {});
    return true;
  }

  Future _bottomSheetAddPayment() async {
    showBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: new Column(
              children: <Widget>[
                new Divider(
                  color: Colors.grey,
                  height: 3.0,
                ),
                new Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.grey[300],
                  ),
                  margin: EdgeInsets.only(top: 5.0),
                  height: 7.0,
                  width: 30.0,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: _createPaymentButton(
                      () async => await _onAddPaymentBtnClicked(),
                      "Pay",
                      new Icon(
                        Icons.assistant,
                        color: Colors.blue,
                      )),
                ),
                _createPaymentButton(
                    () {},
                    "ADD",
                    new Icon(
                      Icons.add,
                      color: Colors.blue,
                    ))
              ],
            ),
          );
        });
    return true;
  }

  Future<bool> _onGPayBtnClicked() async {
    debugPrint("GooglePay");
    return true;
  }

  _createPaymentButton(VoidCallback callback, String text, Icon icon) {
    var button = new FlatButton.icon(
      shape: new RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: new BorderRadius.circular(30.0)),
      color: Colors.white,
      onPressed: callback,
      textColor: Colors.blue,
      label: new Text(text),
      icon: icon,
    );
    return new Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: button,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => payments[index],
        itemCount: payments.length,
        reverse: false,
      ),
    );
  }
}

class SetupTopView extends StatefulWidget {
  SetupTopView();

  static void setImage(File image) {
    _SetupTopViewState.setImage(image);
  }

  @override
  _SetupTopViewState createState() => new _SetupTopViewState();
}

class _SetupTopViewState extends State<SetupTopView> {
  _SetupTopViewState();

  static File imageFile;
  static setImage(File image) {
    imageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          width: 550.0,
          margin: EdgeInsets.only(left: 0.0, top: 25.0),
          child: new Text(
            "Welcome",
            textAlign: TextAlign.left,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
          ),
        ),
        new Container(
          width: 550.0,
          height: 60.0,
          margin: EdgeInsets.only(left: 20.0, bottom: 10.0, top: 15.0),
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 25.0,
                backgroundImage: imageFile == null
                    ? AssetImage("assets/assistant.png")
                    : FileImage(imageFile),
                backgroundColor: Colors.white,
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: new Text(
                  "Joan Wike",
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ListWardrobe extends StatefulWidget {
  ListWardrobe({this.isEditable});
  final bool isEditable;
  @override
  _ListWardrobeState createState() =>
      _ListWardrobeState(isEditable: isEditable);
}

class _ListWardrobeState extends State<ListWardrobe> {
  List<WardrobeItem> wardrobe = <WardrobeItem>[];
  _ListWardrobeState({this.isEditable});
  bool isEditable;
  @override
  void initState() {
    super.initState();
    wardrobe.insert(0,
        new WardrobeItem(new Icon(Icons.ac_unit), "Shirt","\$0.07", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.shopping_cart), "T-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.camera), "Dress-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.add_shopping_cart), "Jacket","Included", true, isEditable));
               wardrobe.insert(0,
        new WardrobeItem(new Icon(Icons.ac_unit), "Shirt","\$0.07", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.shopping_cart), "T-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.camera), "Dress-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.add_shopping_cart), "Jacket","Included", true, isEditable));
               wardrobe.insert(0,
        new WardrobeItem(new Icon(Icons.ac_unit), "Shirt","\$0.07", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.shopping_cart), "T-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.camera), "Dress-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.add_shopping_cart), "Jacket","Included", true, isEditable));
               wardrobe.insert(0,
        new WardrobeItem(new Icon(Icons.ac_unit), "Shirt","\$0.07", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.shopping_cart), "T-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.camera), "Dress-Shirt","Included", false, isEditable));
    wardrobe.insert(
        0,
        new WardrobeItem(
            new Icon(Icons.add_shopping_cart), "Jacket","Included", true, isEditable));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(20.0),
      //height:300.0,
      child: new GestureDetector(
        onTap: () {},
        child: new ListView.builder(
          itemBuilder: (_, int index) => wardrobe[index],
          itemCount: wardrobe.length,
          reverse: false,
        ),
      ),
    );
  }
}

class WardrobeItem extends StatefulWidget {
  WardrobeItem(this._icon, this._item, this.priceLabel, this._isSelected,
      this._isEditable);
  final Icon _icon;
  final String _item;
  final bool _isSelected;
  final bool _isEditable;
  final String priceLabel;

  @override
  _WardrobeItemState createState() => new _WardrobeItemState(
      _icon, _item, _isSelected, priceLabel, _isEditable);
}

class _WardrobeItemState extends State<WardrobeItem> {
  _WardrobeItemState(this._icon, this._item, this._isSelected, this.priceLabel,
      this._isEditable);
  final Icon _icon;
  final String _item;
  final String priceLabel;
  bool _isSelected;
  bool _isEditable;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      height: 40.0,
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 0,
            child: _icon,
          ),
          new Expanded(
            flex: 1,
            child: new Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: new Text(_item),
            ),
          ),
          new Text(priceLabel),
          new Expanded(
            flex: 0,
            child: new GestureDetector(
                onTap: () {
                  _isSelected = !_isSelected;
                  setState(() {});
                },
                child: !_isEditable
                    ? new Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                      )
                    : new Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: new CircleAvatar(
                          backgroundColor:
                              _isSelected ? Colors.blue : Colors.grey,
                          child: new Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      )),
          )
        ],
      ),
    );
  }
}
