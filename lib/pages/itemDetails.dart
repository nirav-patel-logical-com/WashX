import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_itemExpanded.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/BasketModel.dart';
import 'package:wash_x/models/CategoryModel.dart';
import 'package:wash_x/models/WardrobeModel.dart';

class ItemDetails extends StatefulWidget {
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with TickerProviderStateMixin {
  TabController _filterTabController;

  VoidCallback onChanged;

  @override
  void initState() {
    _filterTabController = new TabController(length: 3,vsync: this,initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _filterTabController.dispose();
  }

  List<bool> _itemList = new List();
  List<BasketModel> _basketList = new List();
  List<CategoryModel> _categoriesList = new List();
  List<WardrobeModel> _wardrobeList = new List();
  var _wardrobeScaffoldKey = new GlobalKey<ScaffoldState>();
  PersistentBottomSheetController bottomSheetController;

  var isFirstLoad = true;
  @override
  Widget build(BuildContext context) {
    if (isFirstLoad) {
      for (int i = 0; i < 10; i++) {
        _itemList.insert(0, false);
      }
      isFirstLoad = false;
    }

    return new Scaffold(
      key: _wardrobeScaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: new Stack(
        children: <Widget>[
          _buildWardrobe(),
          new Positioned(
            bottom: 0.0,
            child: _buildBottomColumn(),
          )
        ],
      ),
    );
  }

  _buildWardrobe() {
    return new Container(
      //  child:// new Container(
      child: new ListView(
        padding: EdgeInsets.only(bottom: 105.0),
          children: new List.generate(_itemList.length, (int index) {
        return CustomWardrobeTile(
          index: index,
          list: _itemList,
          isselected: _itemList[index],
          callback: () {
            //  _itemList[index] = !_itemList[index];
          },
        );
      })),
    );
  }

  _buildBottomColumn() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 60.0,bottom: 5.0),
                child: FlatButton.icon(
                  onPressed: () {},
                  label: new Text(
                    "ADD",
                    style: TextStyle(color: Colors.blue, fontSize: 12.0),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  color: Colors.white,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey[300], width: 2.0)),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: FlatButton.icon(
                  onPressed: _showFilterBottomSheet,
                  label: new Text(
                    "FILTER",
                    style: TextStyle(color: Colors.blue, fontSize: 12.0),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                  color: Colors.white,
                  shape: StadiumBorder(
                      side: BorderSide(color: Colors.grey[300], width: 2.0)),
                ),
              )
            ],
          ),
          _buildBottomContainer(),
        ],
      ),
    );
  }

  _showFilterBottomSheet() {
    bottomSheetController = _wardrobeScaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 5.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              boxShadow: [new BoxShadow(blurRadius: 5.0, color: Colors.grey)],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: 40.0,
                  height: 7.0,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              new Container(
                height: 170.0,
                padding: EdgeInsets.only(bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                child: new TabBarView(
                  controller: _filterTabController,
                  children: <Widget>[
                    _buildBasketList(),
                    _buildCategoriesList(),
                    _buildWardrobeList(),
                  ],
                ),
              ),
              new Row(
                children: <Widget>[
                  new Container(
                    width: 60.0,
                    height: 40.0,
                    color: Colors.transparent,
                  ),
                  new Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(right: 10.0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey[350],
                              blurRadius: 2.0,
                              spreadRadius: 2.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(25.0)),
                      child: new TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.blue,
                        isScrollable: false,
                        indicator: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25.0)),
                        controller: _filterTabController,
                        tabs: <Widget>[
                          new Container(
                            height: 25.0,
                            alignment: Alignment.center,
                            child: new Text(
                              "BASKETS",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          new Container(
                            height: 25.0,
                            alignment: Alignment.center,
                            child: new Text(
                              "CATEGORIES",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                          new Container(
                            height: 25.0,
                            alignment: Alignment.center,
                            child: new Text(
                              "WARDROBE",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
              // new ListWardrobe(isEditable: true,)
            ],
          ));
    });
  }

  _buildWardrobeList() {
    _wardrobeList.clear();
    for (int i = 0; i <= 10; i++) {
      _wardrobeList.insert(
          0,
          new WardrobeModel(
              icon: Image.asset("assets/assistant_large.png"),
              title: "WARDROBE"));
    }
    return new ListView(
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      scrollDirection: Axis.horizontal,
      children: List.generate(_basketList.length + 2, (int index) {
        if (index == 0) {
          return new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                //    border: Border.all(color: Colors.grey[300]),
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 3.0,
                      spreadRadius: 3.0)
                ]),
            width: 150.0,
            height: 150.0,
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 80.0,
                  width: 80.0,
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      debugPrint("***********");
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 60.0,
                    ),
                  ),
                ),
                new Text(
                  "NEW",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          );
        } else if (index == 1) {
          return new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            height: 130.0,
            width: 2.0,
            color: Colors.blue[100],
          );
        } else {
          index -= 2;
          var _wardrobeItem = _wardrobeList[index];
          return _buildWardrobeCard(
              index: index,
              icon: _wardrobeItem.icon,
              title: _wardrobeItem.title + "$index");
        }
      }),
    );
  }

  _buildWardrobeCard({int index, Image icon, String title}) {
    return new Stack(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              //border: Border.all(color: Colors.grey[300]),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey[300], blurRadius: 3.0, spreadRadius: 3.0)
              ]),
          width: 150.0,
          height: 150.0,
          child: new Column(
            children: <Widget>[
              new Container(
                height: 80.0,
                width: 80.0,
                margin: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: IconButton(
                    onPressed: () {
                      debugPrint("***********");
                    },
                    icon: icon),
              ),
              new Text(
                title,
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        new Positioned(
            right: 0.0,
            top: 0.0,
            child: new Container(
              child: IconButton(
                onPressed: () {
                  debugPrint("More options clicked");
                },
                icon: new Icon(
                  Icons.more_vert,
                  size: 25.0,
                  color: Colors.black,
                ),
              ),
            ))
      ],
    );
  }

  _buildBasketList() {
    _basketList.clear();
    for (int i = 0; i <= 10; i++) {
      _basketList.insert(
          0, new BasketModel(iconData: MyFlutterApp.tshirt, title: "BASKET"));
    }

    return new ListView(
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      scrollDirection: Axis.horizontal,
      children: List.generate(_basketList.length + 2, (int index) {
        debugPrint(_basketList.length.toString());
        if (index == 0) {
          return new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 3.0,
                      spreadRadius: 3.0)
                ]),
            width: 150.0,
            height: 150.0,
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 80.0,
                  width: 80.0,
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      debugPrint("***********");
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 60.0,
                    ),
                  ),
                ),
                new Text(
                  "NEW",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          );
        } else if (index == 1) {
          return new Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            height: 130.0,
            width: 2.0,
            color: Colors.blue[100],
          );
        } else {
          index -= 2;
          return _buildBasketCard(
              iconData: _basketList[index].iconData,
              title: _basketList[index].title + "$index");
        }
      }),
    );
  }

  _buildBasketCard({IconData iconData, String title, int index}) {
    return new Stack(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(bottom: 5.0),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              // border: Border.all(color: Colors.grey[300]),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey[300], blurRadius: 3.0, spreadRadius: 3.0)
              ]),
          width: 150.0,
          height: 150.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                  height: 75.0,
                  width: 75.0,
                  margin: EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {
                      debugPrint("***********");
                    },
                    icon: Icon(
                      iconData,
                      size: 60.0,
                    ),
                  )),
              new Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        new Positioned(
            right: 0.0,
            top: 0.0,
            child: new Container(
              child: IconButton(
                onPressed: () {
                  debugPrint("More options clicked");
                },
                icon: new Icon(
                  Icons.more_vert,
                  size: 25.0,
                  color: Colors.black,
                ),
              ),
            ))
      ],
    );
  }

  _buildCategoriesList() {
    _categoriesList.clear();
    for (int i = 0; i <= 10; i++) {
      _categoriesList.insert(i,
          new CategoryModel(iconData: MyFlutterApp.shirt_1, title: "CATEGORY"));
    }
    return new ListView(
      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      scrollDirection: Axis.horizontal,
      children: List.generate(_categoriesList.length, (int index) {
        var categoryItem = _categoriesList[index];
        return _buildCategoryCard(
            iconData: categoryItem.iconData,
            title: categoryItem.title + "$index");
      }),
    );
  }

  _buildCategoryCard({IconData iconData, String title}) {
    return new Stack(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.only(bottom: 5.0),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
              // border: Border.all(color: Colors.grey[300]),
              boxShadow: [
                new BoxShadow(
                    color: Colors.grey[300], blurRadius: 3.0, spreadRadius: 3.0)
              ]),
          width: 150.0,
          height: 150.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                  height: 75.0,
                  width: 75.0,
                  margin: EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {
                      debugPrint("***********");
                    },
                    icon: Icon(
                      iconData,
                      size: 60.0,
                    ),
                  )),
              new Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        new Positioned(
            right: 0.0,
            top: 0.0,
            child: new Container(
              child: IconButton(
                onPressed: () {
                  debugPrint("More options clicked");
                },
                icon: new Icon(
                  Icons.more_vert,
                  size: 25.0,
                  color: Colors.black,
                ),
              ),
            ))
      ],
    );
  }

  _buildBottomContainer() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        new BoxShadow(
            color: Colors.grey[300], blurRadius: 5.0, spreadRadius: 3.0)
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Icon(Icons.arrow_back, color: Colors.transparent),
          new Text(
            'WARDROBE',
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          new Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
