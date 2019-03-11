import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wash_x/models/model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
  return remoteConfig;
}

class WashDatabase{
  static final WashDatabase _instance = new WashDatabase._internal();
  factory WashDatabase() {
    return _instance;
  }
  WashDatabase._internal();
  String _email;
  String get email => _email;
  void set email(String value){
    _email = value;
  }

  // ignore: missing_return
  Future<StreamSubscription<DocumentSnapshot>> getWashModel(
      void onData(WashModel wash)) async {
    Firestore.instance
        .collection('users')
        .document(_email)
        .snapshots().listen((DocumentSnapshot document){
      print('-------------------');
      print(document.data);
      print('-------------------');
      DeliveryTimeModel delivery = DeliveryTimeModel.fromMap(document.data['DeliveryTime']);
      AddressModel address = AddressModel.fromMap(document.data['Address']);

      WashModel washModel = new WashModel(
          address: address,
          delivery: delivery);
      onData(washModel);
    });
  }

  // ignore: missing_return
  Future<StreamSubscription<QuerySnapshot>> getBasketModel(
      void onData(BasketModel basket)) async {
    Firestore.instance
        .collection('users')
        .document(_email)
        .collection('Basket')
        .snapshots().listen((QuerySnapshot document){
      print('-------------------');
      print(document.documents.length);
      print('-------------------');

      BasketModel basket = new BasketModel();
      document.documents.forEach((item){
        basket.add(BasketItem.fromMap(item.data, item.documentID));
      });

//      DeliveryTimeModel delivery = DeliveryTimeModel.fromMap(document.data['DeliveryTime']);
//      AddressModel address = AddressModel.fromMap(document.data['Address']);

//      WashModel washModel = new WashModel(
//          address: address,
//          delivery: delivery);
      onData(basket);
    });
  }

  void addItemBasket(BasketItem item){
    Firestore.instance
        .collection('users')
        .document(_email)
        .collection('Basket')
        .document()
        .setData(item.toJson())
        .catchError((value)=>print('error:$value'));
  }

  void updateAddress(AddressModel address){
    Map<String, dynamic> map = {
      'Address':address.toJson()
    };
    print('map:$map');
    Firestore.instance
        .collection('users')
        .document(_email)
        .updateData(map).catchError((onValue){
      print('error:$onValue');
    });
  }
  void updateDeliveryTime(DeliveryTimeModel time){
    Map<String, dynamic> map = {
      'DeliveryTime':time.toJson()
    };
    print('map:$map');
    Firestore.instance
        .collection('users')
        .document(_email)
        .updateData(map).catchError((onValue){
      print('error:$onValue');
    });
  }



}