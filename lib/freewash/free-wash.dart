import 'package:flutter/material.dart';
import 'package:wash_x/models/slider-model.dart';
import 'package:wash_x/freewash/slider_list.dart';
import 'package:wash_x/custom/box-decoration-param.dart';

//import 'package:washx/model/slider-model.dart';
//import 'package:washx/ui/box-decoration-param.dart';
//import 'package:washx/ui/slider_list.dart';

class FreeWash extends StatefulWidget {
  @override
  _FreeWashState createState() => _FreeWashState();
}

class _FreeWashState extends State<FreeWash>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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

//  Future<List<SliderModel>> fetchUser() async {
//    final response = await http.get('https://api.myjson.com/bins/xsz7o');
//    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//    _items = parsed.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
//  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _items.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth;
    setState(() {
      phoneWidth = (MediaQuery.of(context).size.width * 90.0) / 100.0;
    });
    return new Scaffold(
      body: new Builder(
        builder: (BuildContext context) {
          return new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: new Container(
              color: Colors.white70,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(
                    height: 70.0,
                  ),
                  new GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(content: Text("Tap"));
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: new BoxDecorationParam(
                              5.0, 5.0, 5.0, 5.0, Colors.lightBlueAccent)
                          .getBoxDecoration(),
                      height: 150.0,
                      width: 120.0,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: new Container(
                                    decoration: new BoxDecorationParam(
                                            5.0, 5.0, 5.0, 5.0, Colors.white70)
                                        .getBoxDecoration(),
                                    height: 4.0,
                                    width: 30.0,
                                  )),
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 2.0,
                                          right: 2.0,
                                          bottom: 2.0),
                                      child: new Container(
                                        decoration: new BoxDecorationParam(5.0,
                                                5.0, 5.0, 5.0, Colors.white70)
                                            .getBoxDecoration(),
                                        height: 4.0,
                                        width: 5.0,
                                      )),
                                  new Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: new Container(
                                        decoration: new BoxDecorationParam(5.0,
                                                5.0, 5.0, 5.0, Colors.white70)
                                            .getBoxDecoration(),
                                        height: 4.0,
                                        width: 5.0,
                                      )),
                                  new Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0,
                                          top: 2.0,
                                          right: 8.0,
                                          bottom: 2.0),
                                      child: new Container(
                                        decoration: new BoxDecorationParam(5.0,
                                                5.0, 5.0, 5.0, Colors.white70)
                                            .getBoxDecoration(),
                                        height: 4.0,
                                        width: 5.0,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          new Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0)),
                          new Container(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text('2',
                                  style: new TextStyle(
                                      color: Colors.redAccent, fontSize: 16.0)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              alignment: Alignment.center)
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 20.0,
                  ),
                  new Container(
                    alignment: Alignment.center,
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Text('2370',
                              style: new TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold)),
                        ),
                        new Text('POINTS',
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  new SizedBox(
                    height: 30.0,
                  ),
                  new Container(
                    padding: const EdgeInsets.all(3.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Container(
                                  child: new Image.asset(
                                    'assets/images/gift.png',
                                    fit: BoxFit.cover,
                                    height: 50.0,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3.0,
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Container(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text('HOW IT WORKS',
                                  style: new TextStyle(fontSize: 12.0)),
                              new Text('MORE WAYS TO LEARN',
                                  style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.lightBlueAccent))
                            ],
                          ),
                        ),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new SizedBox.fromSize(
                          size: Size.fromHeight(200.0),
                          child: new ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              new Row(
                                children: [
                                  new Card(
                                    child: new Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: new Text(
                                            'For every action you take to help us grow you earn points, 1000 points equals to one basic load. Each friend that signs up and pays for their first pages.wash you and your friend received 1000 points equaling to free pages.wash fro you and your friend. If your friend signed up for a subscription you both get one month free.'),
                                        height: 180.0,
                                        width: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? phoneWidth
                                            : 370.0),
                                  ),
                                  new Card(
                                    child: SliderList(
                                        sliders: _items,
                                        tabController: _tabController,
                                        height: 180.0,
                                        width: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? phoneWidth
                                            : 370.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
