import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_tab_bar.dart';
import 'package:wash_x/custom/custom_tab_bar_incative.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/giftwash/contacts-list.dart';
import 'package:wash_x/giftwash/gift_slider_list.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/custom/box-decoration-param.dart';
import 'package:wash_x/widgets/linear_percent_indicator.dart';

class GiftWash extends StatefulWidget {
  final Function callback;

  GiftWash(this.callback);

  @override
  _FreeWashState createState() => _FreeWashState();
}

class _FreeWashState extends State<GiftWash>
    with SingleTickerProviderStateMixin {
  int num;
  double offset = 20.0;
  double offset_lf = 14.0;
  bool isShow = false;

  int selectedItem = 0;
  int selectedCardItem = 0;
  List<Widget> cardList = new List<Widget>();

  TabController _tabController;
  List<String> pages = ['HOME', 'POINTS', 'GIFTS', 'DONATE'];
  String _currentTab;
  bool _isActiveWashVisible = false;

  static const List<SliderModel> _items = const <SliderModel>[
    const SliderModel(
        image: 'assets/images/contacts_96x96.png',
        title: 'Invite people from your contacts',
        subTitle: 'Tab to import your contacts- 271 potential washes',
        link: 'IMPORT'),
    const SliderModel(
        image: 'assets/images/share_96x96.png',
        title: 'Share on social media',
        subTitle: 'Tell people about your experience using WashX',
        link: 'SHARE'),
    const SliderModel(
        image: 'assets/images/qrcode_96x96.png',
        title: 'Show your QR Code',
        subTitle: 'Tell people about your experience using WashX',
        link: 'SHOW'),
    const SliderModel(
        image: 'assets/images/link_96x96.png',
        title: 'Send a link',
        subTitle:
            "It's easier with a link and it contains your code so your friend dosen't have to type it",
        link: 'SEND'),
    const SliderModel(
        image: 'assets/images/gift.png',
        title: 'Gift A Wash',
        subTitle:
            "The best way to show appreciation is when one needs it most. Gift a pages.wash to ease the load",
        link: 'GIFT'),
  ];

  @override
  void initState() {
    _currentTab = pages[0];
    super.initState();
    _tabController =
        new TabController(length: pages.length, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      _currentTab = pages[_tabController.index];
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthProgress = (MediaQuery.of(context).size.width) * 0.9;
    double dHeight = (MediaQuery.of(context).size.height) * 0.9;

    cardList.clear();
    cardList.add(Container(color: Colors.red.withOpacity(0.3), height: 350.0));
    cardList.add(Container(color: Colors.yellow, height: 350.0));
    cardList.add(Container(color: Colors.red.withOpacity(0.1), height: 350.0));
    cardList.add(
        Container(color: Colors.blueAccent.withOpacity(0.7), height: 350.0));
    cardList.add(Container(
      padding:
          EdgeInsets.only(left: 25.0, right: 15.0, bottom: 10.0, top: 10.0),
      color: Colors.brown.withOpacity(0.8),
      height: 350.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: IndexedStack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 11.0),
                          child: Text(
                            "Happy Birthday!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                width: 24.0,
                                height: 24.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 15.0, right: 50.0),
                              child: Text(
                                "Mandy Marcus",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.network(
                              "http://blog.32leaves.net/wp-content/uploads/2009/02/cake.png",
                              height: 68.0,
                              width: 68.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 11.0),
                          child: Text(
                            "Congratulations!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "You have accumulated a lot of points, make use of it, next time you wash make sure to "
                                "select Free Wash as your payment option elect Free Wash as your payment option select Free Wash as your payment option",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 0.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 25.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: new Text(
                                '2370',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700),
                              )),
                              Container(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: new Text(
                                    'POINTS',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: new BoxDecorationParam(
                                  5.0, 5.0, 5.0, 5.0, Colors.blueAccent)
                              .getBoxDecoration(),
                          height: 90.0,
                          width: 75.0,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11.0),
                                      child: new Container(
                                        decoration: new BoxDecorationParam(5.0,
                                                5.0, 5.0, 5.0, Colors.white70)
                                            .getBoxDecoration(),
                                        height: 4.0,
                                        width: 18.0,
                                      )),
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7.0,
                                              top: 2.0,
                                              right: 2.0,
                                              bottom: 2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                      new Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                      new Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0,
                                              top: 2.0,
                                              right: 8.0,
                                              bottom: 2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              new Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7.0)),
                              new Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('4',
                                      style: new TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16.0)),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  alignment: Alignment.center)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
                index: selectedItem,
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Column(
                    children: <Widget>[
                      InkResponse(
                        child: Icon(
                          Icons.card_giftcard,
                          size: 20.0,
                        ),
                        onTap: () {
                          setState(() {
                            selectedItem = 0;
                            selectedCardItem = 4;
                          });
                        },
                      ),
                      Container(
                          width: 20.0,
                          height: 3.0,
                          decoration: new BoxDecoration(
                            color: selectedItem == 0
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Column(
                    children: <Widget>[
                      InkResponse(
                        child: Icon(
                          Icons.message,
                          size: 20.0,
                        ),
                        onTap: () {
                          setState(() {
                            selectedItem = 1;
                            selectedCardItem = 4;
                          });
                        },
                      ),
                      Container(
                          width: 20.0,
                          height: 3.0,
                          decoration: new BoxDecoration(
                            color: selectedItem == 1
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Column(
                    children: <Widget>[
                      InkResponse(
                        child: Icon(
                          Icons.reply,
                          size: 20.0,
                        ),
                        onTap: () {
                          setState(() {
                            selectedItem = 2;
                            selectedCardItem = 4;
                          });
                        },
                      ),
                      Container(
                          width: 20.0,
                          height: 3.0,
                          decoration: new BoxDecoration(
                            color: selectedItem == 2
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: Column(
                    children: <Widget>[
                      InkResponse(
                        child: Icon(
                          Icons.info,
                          size: 20.0,
                        ),
                        onTap: () {
                          setState(() {
                            selectedItem = 3;
                            selectedCardItem = 4;
                          });
                        },
                      ),
                      Container(
                          width: 20.0,
                          height: 3.0,
                          decoration: new BoxDecoration(
                            color: selectedItem == 3
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
    cardList.add(
        Container(color: Colors.deepPurple.withOpacity(0.5), height: 350.0));
    cardList.add(Container(color: Colors.green.shade600, height: 350.0));
    cardList.add(Container(color: Colors.purple[500], height: 350.0));

    num = cardList.length;

    _buildBottomColumn() {
      return new Container(
        margin: EdgeInsets.only(bottom: 56.0),
        width: MediaQuery.of(context).size.width,
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 60.0, bottom: 5.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: new Text(
                      "SEND A GIFT",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                    ),
                    color: Colors.white,
                    shape: StadiumBorder(
                        // side: BorderSide(color: Colors.grey[300], width: 2.0)
                        ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                  child: RaisedButton(
                    onPressed: () {},
                    child: new Text(
                      "DONTE",
                      style:
                          TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                    ),
                    color: Colors.white,
                    shape: StadiumBorder(),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    //build card Stack for Gift view
    _buildColorCard() {
      return Stack(
        alignment: Alignment.topCenter,
        children: List<Widget>.generate(
            num - 1,
            (val) => Positioned(
                top: 25.0 * val,
                left: offset_lf,
                bottom: offset_lf,
                right: offset_lf,
                child: InkWell(
                  child: Card(
                    child: cardList[val],
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(12.0))),
                  ),
                  onTap: () {
                    setState(() {
                      selectedCardItem = val;
                      isShow = true;
                    });
                  },
                ))).toList()
          ..add(
            Container(
              height: 300.0,
              child: isShow
                  ? Padding(
                      child: GestureDetector(
                        child: Card(
                          child: cardList[selectedCardItem],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(12.0))),
                        ),
                        onTapDown: (TapDownDetails details) {
                          setState(() {
                            isShow = false;
                          });
                        },
                      ),
                      padding: EdgeInsets.only(
                          bottom: (4) * offset,
                          top: 60.0,
                          left: offset - 16,
                          right: offset - 16),
                    )
                  : Container(
                      height: 0.0,
                    ),
            ),
          ),
      );
    }

    // Build Home View
    _buildHomeView() {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: dHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: new BoxDecorationParam(
                          5.0, 5.0, 5.0, 5.0, Colors.blueAccent)
                      .getBoxDecoration(),
                  height: 90.0,
                  width: 75.0,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11.0),
                              child: new Container(
                                decoration: new BoxDecorationParam(
                                        5.0, 5.0, 5.0, 5.0, Colors.white70)
                                    .getBoxDecoration(),
                                height: 4.0,
                                width: 18.0,
                              )),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7.0,
                                      top: 2.0,
                                      right: 2.0,
                                      bottom: 2.0),
                                  child: new Container(
                                    decoration: new BoxDecorationParam(
                                            5.0, 5.0, 5.0, 5.0, Colors.white70)
                                        .getBoxDecoration(),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Container(
                                    decoration: new BoxDecorationParam(
                                            5.0, 5.0, 5.0, 5.0, Colors.white70)
                                        .getBoxDecoration(),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                              new Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      top: 2.0,
                                      right: 8.0,
                                      bottom: 2.0),
                                  child: new Container(
                                    decoration: new BoxDecorationParam(
                                            5.0, 5.0, 5.0, 5.0, Colors.white70)
                                        .getBoxDecoration(),
                                    height: 4.0,
                                    width: 4.0,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0)),
                      new Container(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text('2',
                              style: new TextStyle(
                                  color: Colors.red, fontSize: 16.0)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          alignment: Alignment.center)
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  height: 140.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, top: 10.0),
                            alignment: Alignment.topLeft,
                            child: new Text(
                              'POINTS',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: new Text(
                                  '2381',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.0),
                                ),
                              ),
                              new Text(
                                '3000',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: LinearPercentIndicator(
                            alignment: MainAxisAlignment.center,
                            width: widthProgress,
                            lineHeight: 8.0,
                            percent: 0.3,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            backgroundColor: Colors.blueAccent.withOpacity(0.3),
                            progressColor: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: new Text(
                          'HOW IT WORKS',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.all(5.0),
                        child: new Text(
                          'For every action you take to help us grow you earn points, 1000 points equals to one basic load. Each friend that signs up and pays for their first pages.wash you and your friend received 1000 points equaling to free pages.wash fro you and your friend. If your friend signed up for a subscription you both get one month free.',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5.0),
                        alignment: Alignment.bottomRight,
                        child: new Text(
                          'DISMISS',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                )),
              ),
              Container(
                height: 140.0,
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: widthProgress,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: new Text(
                                      'PROGRESS',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                  Expanded(
                                      child: Icon(
                                    Icons.highlight_off,
                                    color: Colors.blueAccent,
                                    size: 30.0,
                                  )),
                                  new Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Text(
                                      'you do not have any points in progress',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blueAccent),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: 10.0, top: 5.0),
                                      alignment: Alignment.topRight,
                                      child: new Text(
                                        "1",
//                                    textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 11.0),
                                      )),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new CircleAvatar(
                                          backgroundImage: new NetworkImage(
                                              'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg'),
                                          radius: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    left: 5.0, bottom: 4.0),
                                                child: new Text(
                                                  "Mendy Marcus",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    left: 5.0),
                                                child: new Text(
                                                  "Pending invite",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.grey,
                                                      fontSize: 12.0),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'SEND A REMINDER',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.card_giftcard,
                                            size: 30.0,
                                            color: Colors.black,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 4.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Gift a Wash",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 10.0),
                                                child: new Text(
                                                  "The best way to show appreciation is when one needs it most. Gift a wash to easy the load",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'GIFT',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            "images/ic_facebook.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: new Text(
                                                  "Shared on Facebook",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    left: 5.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        new Text(
                                                          "CLICKS",
//                                    textAlign: TextAlign.center,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11.0),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4.0)),
                                                        new Text(
                                                          "21",
//                                    textAlign: TextAlign.center,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10.0),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .only(left: 5.0)),
                                                    Column(
                                                      children: <Widget>[
                                                        new Text(
                                                          "WASHES",
//                                    textAlign: TextAlign.center,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11.0),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4.0)),
                                                        new Text(
                                                          "3",
//                                    textAlign: TextAlign.center,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 10.0),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    alignment: Alignment.bottomRight,
                                    child: new Text(
                                      'REPOST',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))),
              ),
              Container(
                height: 140.0,
                margin: EdgeInsets.all(10.0),
                child: new Card(
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.contacts,
                                            size: 30.0,
                                            color: Colors.blueAccent,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Import your contacts",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "You have 426 contacts that can be potantial point.",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      onTap: () {
                                        this.widget.callback(PageType.CONTACT);
                                      },
                                      child: new Text(
                                        'IMPORT',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.share,
                                            size: 30.0,
                                            color: Colors.black,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Share on social media",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "Tell pepole about your experience using Wash X",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'SHARE',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            "images/ic_qr_code.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Show your QR Code",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "Tell pepole about your experience using Wash X",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'SHOW',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Image.asset(
                                            "images/ic_link_share.png",
                                            height: 30.0,
                                            width: 30.0,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Send a link",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "It's easier with a link and it contains your code so your friend dosen't have type it",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'SEND',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.card_giftcard,
                                            size: 30.0,
                                            color: Colors.black,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "Gift a Wash",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "The best way to show appreciation is when one needs it most. Gift a wash to easy the load",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'SEND',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey[350],
                                  )),
                              width: widthProgress * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Icon(
                                            Icons.card_giftcard,
                                            size: 30.0,
                                            color: Colors.black,
                                          ),
                                          margin: EdgeInsets.only(right: 10.0),
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    bottom: 8.0),
                                                alignment: Alignment.topLeft,
                                                child: new Text(
                                                  "DONATE",
//                                    textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueAccent,
                                                      fontSize: 12.0),
                                                )),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    right: 2.0),
                                                child: new Text(
                                                  "The best way to show appreciation is when one needs it most. Gift a wash to easy the load",
                                                  textAlign: TextAlign.justify,
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize: 11.0),
                                                )),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: new Text(
                                      'GIFT',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ))),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  height: 140.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, top: 10.0),
                            alignment: Alignment.topLeft,
                            child: new Text(
                              'GIFT A WASH',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                  margin: EdgeInsets.all(10.0),
                  height: 140.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0, top: 10.0),
                            alignment: Alignment.topLeft,
                            child: new Text(
                              'YOUR GIFTS',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                height: 80.0,
              )
            ],
          ),
        ),
      );
    }

    // Build Point View
    _buildPointView() {
      return Container(
        child: Center(
          child: Text(
            "POINTS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    // Build Gift View
    _buildGiftView() {
      return Column(
        children: <Widget>[
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(14.0),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(22.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: new Text(
                                    'Congratulations!',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 10.0, right: 20.0),
                                  child: new Text(
                                    'You have accumulated a lot of points, meke use of it, next time you wash make sure to select Free Wash as your payment option',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12.0),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: new BoxDecorationParam(
                                  5.0, 5.0, 5.0, 5.0, Colors.blueAccent)
                              .getBoxDecoration(),
                          height: 90.0,
                          width: 75.0,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 11.0),
                                      child: new Container(
                                        decoration: new BoxDecorationParam(5.0,
                                                5.0, 5.0, 5.0, Colors.white70)
                                            .getBoxDecoration(),
                                        height: 4.0,
                                        width: 18.0,
                                      )),
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Padding(
                                          padding: const EdgeInsets.only(
                                              left: 7.0,
                                              top: 2.0,
                                              right: 2.0,
                                              bottom: 2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                      new Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                      new Padding(
                                          padding: const EdgeInsets.only(
                                              left: 2.0,
                                              top: 2.0,
                                              right: 8.0,
                                              bottom: 2.0),
                                          child: new Container(
                                            decoration: new BoxDecorationParam(
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    5.0,
                                                    Colors.white70)
                                                .getBoxDecoration(),
                                            height: 4.0,
                                            width: 4.0,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              new Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7.0)),
                              new Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text('4',
                                      style: new TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 16.0)),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  alignment: Alignment.center)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(14.0))),
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: new Text(
                          '9',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700),
                        )),
                        Container(
                            padding: EdgeInsets.only(top: 4.0),
                            child: new Text(
                              'GIFTS',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: new Text(
                          '2370',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700),
                        )),
                        Container(
                            margin: EdgeInsets.only(top: 4.0),
                            child: new Text(
                              'POINTS',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0),
                            ))
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              _buildColorCard(),
              isShow
                  ? Container(
                      height: 0.0,
                    )
                  : _buildBottomColumn(),
            ],
          ),
        ],
      );
    }

    // Build Donate View
    _buildDonateView() {
      return Container(
        child: Center(
          child: Text(
            "DONATE",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    _buildTabBarView() {
      return new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          _buildHomeView(),
          _buildPointView(),
          _buildGiftView(),
          _buildDonateView(),
        ],
      );
    }

    //Build Tab bar
    _buildTabBar() {
      return new Container(
        height: 48.0,
        child: TabBar(
            controller: _tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey[350],
            indicator: new CustomTabIndicator(),
            tabs: [
              Tab(
                child: Text(
                  'HOME',
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
              ),
              Tab(
                child: Text(
                  'POINTS',
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
              ),
              Tab(
                child: Text(
                  'GIFTS',
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
              ),
              Tab(
                child: Text(
                  'DONATE',
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
              ),
            ]),
      );
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildTabBarView(),
          Container(
            height: 45.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.black12),
              ),
            ),
            margin: EdgeInsets.only(top: 12.0),
            padding: EdgeInsets.only(left: 10.0, right: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkResponse(
                  onTap: () {
                    this.widget.callback(PageType.WASHPAGE);
                  },
                  child: Icon(Icons.arrow_back),
                ),
                new Expanded(
                  child: _buildTabBar(),
                ),
                InkResponse(
                  onTap: () {},
                  child: Icon(Icons.more_vert),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 55.0, right: 15.0),
            height: 40.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blueAccent,
              onPressed: () {},
              child: Icon(
                Icons.card_giftcard,
                color: Colors.black,
                size: 25.0,
              ),
              mini: true,
            ),
            alignment: Alignment.bottomRight,
          )
        ],
      ),
    );
  }
}
