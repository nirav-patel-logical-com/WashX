import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wash_x/viewModels/WardrobeModel.dart';

class NewWashItem extends StatelessWidget {
  final WardrobeModel itemModel;
  final PersistentBottomSheetController bottomSheetController;
  final String error = "";

  NewWashItem(this.itemModel,this.bottomSheetController);

  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
      model: itemModel,
      child: ScopedModelDescendant<WardrobeModel>(
          builder: (context, child, model) {
        return new Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          height: model.bottomSheetSize,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ScopedModelDescendant<WardrobeModel>(
                builder: (context, child, model) {
                  String data = model.topLabel;
                  if (data.isNotEmpty || data != null) {
                    return new Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: new Text(
                        data,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                },
              ),
              new Expanded(
                child: _buildBottom(),
              ),
              ScopedModelDescendant<WardrobeModel>(
                builder: (context, child, model) {
                  if (model.nextButtonLabel.isNotEmpty ||
                      model.bottomDescription.isNotEmpty) {
                    return new Container(
                      height: 50.0,
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
                                        TextSpan(children: <TextSpan>[
                                      new TextSpan(
                                        text: model.bottomDescription,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 11.0),
                                      ),
                                      new TextSpan(
                                        text: model.bottomTrailDescription,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]))),
                          ),
                          model.nextButtonLabel.isEmpty
                              ? new Container()
                              : new Center(
                                  child: Padding(
                                  padding: EdgeInsets.only(left: 3.0),
                                  child: RaisedButton(
                                    shape: StadiumBorder(),
                                    color: Colors.white,
                                    onPressed: (){
                                      if(model.step==8){
                                        bottomSheetController.close();                          
                                      }
                                      model.onNewItemBtnClicked(context: context);
                                    },
                                    child: new Text(
                                      model.nextButtonLabel,
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
              )
            ],
          ),
        );
      }),
    );
  }

  
  _buildBottom() {
    return ScopedModelDescendant<WardrobeModel>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        var step = model.step;
        if (step == 1) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            color: Colors.white,
            child: Form(
              child: new TextFormField(
                //onSubmitted: (value) => model.addName(value),
                // onFieldSubmitted: (x) =>  x.isEmpty || x == null?error="sorry":model.addName(x),
                onFieldSubmitted: (x) => model.addName(x),
                validator: (x) => x.isEmpty || x == null ? "field empty" : null,

                style: new TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                decoration: new InputDecoration(
                  errorText: error.isEmpty ? null : error,
                  contentPadding: const EdgeInsets.symmetric(vertical: 17.0),
                  prefixIcon: new IconButton(
                    onPressed: null,
                    icon: new Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[350], shape: BoxShape.circle),
                    ),
                    color: Colors.black,
                  ),
                  labelText: "NAME",
                  labelStyle: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.blue,
                  ),
                  hintStyle: new TextStyle(fontSize: 10.0, color: Colors.grey),
                  border: new OutlineInputBorder(
                      gapPadding: 8.0,
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          new BorderSide(color: Colors.grey, width: 10.0)),
                ),
              ),
            ),
          );
        } else if (step == 2) {
          return new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                model.washBrandList == null ? 0 : model.washBrandList.length,
            itemBuilder: (_, int index) {
              var item = model.washBrandList[index];
              return new GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 85.0,
                  height: 85.0,
                  decoration: BoxDecoration(boxShadow: [
                    new BoxShadow(
                        blurRadius: 1.5,
                        spreadRadius: 2.0,
                        color: Colors.grey[350],
                        offset: Offset(0.0, 2.5))
                  ], color: Colors.white, shape: BoxShape.circle),
                  child: IconTheme(
                    child: item.icon,
                    data: IconThemeData(size: 50.0),
                  ),
                ),
                onTap: () => model.addBrand(item.name),
              );
            },
          );
        } else if (step == 3) {
          return Container(
            color: Colors.white,
            child: GridView.builder(
              itemCount: model.washCategoryList.length,
              padding: EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (_, int index) {
                var item = model.washCategoryList[index];
                if (!item.isSelected) {
                  return new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                              boxShadow: [
                                new BoxShadow(
                                    spreadRadius: 2.0,
                                    blurRadius: 1.5,
                                    offset: Offset(0.0, 2.0),
                                    color: Colors.grey[350]),
                              ],
                              shape: BoxShape.circle),
                          child: new IconButton(
                            icon: Icon(
                              item.icon,
                              size: 50.0,
                            ),
                            onPressed: () =>
                                model.selectCategory(item.categoryName, index),
                          ),
                        ),
                      ),
                      new Text(
                        item.categoryName,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                } else {
                  return new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: new IconButton(
                            icon: Icon(
                              item.icon,
                              size: 50.0,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                model.selectCategory(item.categoryName, index),
                          ),
                        ),
                      ),
                      new Text(
                        item.categoryName,
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    ],
                  );
                }
              },
            ),
          );
        } else if (step == 4) {
          return new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.washColor == null ? 0 : model.washColor.length,
            itemBuilder: (_, int index) {
              var item = model.washColor[index];
              return new GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: 75.0,
                  height: 75.0,
                  decoration:
                      BoxDecoration(color: item.color, shape: BoxShape.circle),
                ),
                onTap: () => model.addColor(item.colorName),
              );
            },
          );
        } else if (step == 5) {
          return new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.washPattern == null ? 0 : model.washPattern.length,
            itemBuilder: (_, int index) {
              var item = model.washPattern[index];
              return new GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  width: 100.0,
                  height: 100.0,
                  child: Icon(
                    item.icon,
                    size: 50.0,
                    color: Colors.orange,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                ),
                onTap: () => model.addPatter(item.pattern),
              );
            },
          );
        } else if (step == 6) {
          return Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                // border: new Border.all(color: Colors.black12),
                boxShadow: [
                  new BoxShadow(
                      blurRadius: 1.5,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 2.0),
                      color: Colors.grey[350])
                ],
                borderRadius: new BorderRadius.all(Radius.circular(8.0))),
            margin: new EdgeInsets.all(10.0),
            padding: EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.message,
                ),
                Padding(padding: EdgeInsets.only(left: 6.0, top: 4.0)),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (x) => model.addDescription(x),
                    onSubmitted: (x) => model.onNewItemBtnClicked,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        decorationColor: Colors.black),
                    decoration: new InputDecoration.collapsed(
                      hintText: "\n \n Write here the description of the Item",
                      hintStyle: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          );
        }
        if (step == 7) {
          return Container(
            child: SingleChildScrollView(
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
                            offset: Offset(0.0, 3.0),
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
                        new Text(
                          itemModel.item.name == null
                              ? ""
                              : itemModel.item.name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w300),
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
                            offset: Offset(0.0, 3.0),
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
                        new FlatButton.icon(
                          color: Colors.white,
                          // shape: StadiumBorder(),
                          icon: IconTheme(
                            child: Icon(
                              itemModel.washBrandList
                                  .where((x) => x.name == itemModel.item.brand)
                                  .first
                                  .icon
                                  .icon,
                            ),
                            data: IconThemeData(size: 20.0),
                          ),
                          label: new Text(
                            itemModel.item.brand == null
                                ? ""
                                : itemModel.item.brand,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w400),
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
                            offset: Offset(0.0, 3.0),
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
                        new Row(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.grey[350],
                                      blurRadius: 1.5,
                                      spreadRadius: 2.0,
                                      offset: Offset(0.5, 2.0)),
                                ],
                                color: Colors.white,
                              ),
                              child: new Text(
                                itemModel.item.category == null
                                    ? ""
                                    : itemModel.item.category,
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                            ),
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
                            offset: Offset(0.0, 3.0),
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
                        new Row(
                          children: <Widget>[
                            new Container(
                              margin: EdgeInsets.only(left: 0.0, top: 10.0),
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //boxShadow: [
                                //   new BoxShadow(
                                //       color: Colors.grey[350],
                                //       blurRadius: 1.0,
                                //       spreadRadius: 1.5,
                                //       offset: Offset(0.5, 2.0)),
                                // ],
                                color: itemModel.washColor
                                    .where((x) =>
                                        x.colorName == itemModel.item.color)
                                    .first
                                    .color,
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
                            offset: Offset(0.0, 3.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "DESCRIPTION",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        new Text(itemModel.item.description == null
                            ? ""
                            : itemModel.item.description)
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
                            offset: Offset(0.0, 3.0),
                            color: Colors.grey[350])
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.white,
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "PATTERN",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        new Container(
                          child: new Icon(
                            itemModel.washPattern
                                .where(
                                    (x) => x.pattern == itemModel.item.pattern)
                                .first
                                .icon,
                            color: Colors.yellow,
                          ),
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
                            offset: Offset(0.0, 3.0),
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
                        new Container(
                          height: 50.0,
                        )
                        // new Row(
                        //   children: <Widget>[
                        //     new Container(
                        //       margin: EdgeInsets.only(top: 10.0),
                        //       width: 30.0,
                        //       height: 30.0,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         boxShadow: [
                        //           new BoxShadow(
                        //             color: Colors.grey[350],
                        //             blurRadius: 1.5,
                        //             spreadRadius: 2.0,
                        //           ),
                        //         ],
                        //         color: Colors.green,
                        //       ),
                        //     ),
                        //     new Container(
                        //       margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        //       width: 40.0,
                        //       height: 40.0,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         boxShadow: [
                        //           new BoxShadow(
                        //             color: Colors.grey[350],
                        //             blurRadius: 1.5,
                        //             spreadRadius: 2.0,
                        //           ),
                        //         ],
                        //         color: Colors.blue,
                        //       ),
                        //       child: new Icon(Icons.watch_later),
                        //     )
                        //   ],
                        // )
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
              "Item Added Successfully",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}
