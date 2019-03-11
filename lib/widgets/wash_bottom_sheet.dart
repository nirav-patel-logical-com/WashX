import 'package:flutter/material.dart';
import 'package:wash_x/helpers/helper.dart';
import 'package:wash_x/models/model.dart';
import 'package:wash_x/themes.dart';

class WashBottomSheet extends StatelessWidget {
  final List items;

  const WashBottomSheet({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return BasketItem(item: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BasketItem extends StatelessWidget {
  final item;

  const BasketItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          children: <Widget>[
            new ListTile(
              leading: Icon(icons[item.clothe]),
              title: SizedBox(
                height: 25.0,
                child: Text(
                  '${item.clothe} \n',
                  style: washTheme.textTheme.title,
                ),
              ),
              subtitle: Text(
                '${item.price}\$',
                style: washTheme.textTheme.headline,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'PICKED UP',
                    style: washTheme.textTheme.subhead,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        //TODO
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                height: 4.0,
                child: LinearProgressIndicator(
                  value: 0.2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
ActionChip(
backgroundColor: Colors.blueAccent,
label: new Text('WASH',
style: new TextStyle(color: Colors.white)),
onPressed: () {})
*/
