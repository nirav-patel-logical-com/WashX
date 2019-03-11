import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WashModel extends Model{
  WashModel({this.delivery, this.address});

  AddressModel address;
  DeliveryTimeModel delivery;

  List<BasketItem> _items = [];
  List<BasketItem> get items => _items;

  List<WashRemoteItem> _configs = [];
  List<WashRemoteItem> get configs => _configs;

  void add(BasketItem item){
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearBasket(){
    _items.clear();
    notifyListeners();
  }

  void set configs(value){
    _configs = value;
    notifyListeners();
  }

  void clearConfig(){
    _configs.clear();
    notifyListeners();
  }

  void addItem(WashRemoteItem item){
    _configs.add(item);
    notifyListeners();
  }
}

class PaymentIssue extends Model{
  DateTime date;
  double ammount;
  String id;

  PaymentIssue({this.ammount, this.date, this.id});
  factory PaymentIssue.fromMap(Map<String, dynamic> map){
    return new PaymentIssue(
        ammount: map['ammount'],
        date: map['date'],
        id: map['id']
    );
  }
}

class WashRemoteItem extends Model{
  String menu_title;
  String menu_image;
  bool is_active;
  int menu_id;

  WashRemoteItem({
    this.menu_title,
    this.menu_image,
    this.is_active,
    this.menu_id});

  factory WashRemoteItem.fromMap(Map<String, dynamic> map){
    return new WashRemoteItem(
        is_active: map['is_active'],
        menu_id: map['manu_id'],
        menu_image: map['menu_image'],
        menu_title: map['menu_title']
    );
  }
}

class DeliveryTimeModel extends Model {
  DeliveryTimeModel({this.time, this.weekday,this.ondemand});

  String time;
  String weekday;
  bool ondemand;

  void set setTime(String value){
    time = value;
    notifyListeners();
  }

  void set setWeekday(String value){
    weekday = value;
    notifyListeners();
  }

  void set setOndemand(bool value){
    ondemand = value;
    notifyListeners();
  }

  factory DeliveryTimeModel.fromMap(Map<dynamic, dynamic> map){
    return new DeliveryTimeModel(
        time: map['time'],
        weekday: map['weekday'],
        ondemand:map['ondemand']
    );
  }

  Map<String, dynamic> toJson() => {
    'time':time,
    'weekday':weekday,
    'ondemand':ondemand
  };
}

class AddressModel extends Model{
  AddressModel({this.first, this.second,this.addresstype});

  String addresstype;
  String first;
  String second;

  factory AddressModel.fromMap(Map<dynamic, dynamic> map){
    return new AddressModel(
        first:map['line1'],
        second:map['line2'],
        addresstype:map['type']);
  }

  Map<String, dynamic> toJson() => {
    'line1': first,
    'line2': second,
    'type': addresstype
  };

  String get line1 => first;
  set line1(String value) {
    first = value;
    notifyListeners();
  }

  String get line2 => second;
  set line2(String value) {
    second = value;
    notifyListeners();
  }

  String get addressType => addresstype;
  set addressType(String value){
    addresstype = value;
    print(addresstype);
    notifyListeners();
  }
  static AddressModel of(BuildContext context) =>
      ScopedModel.of<AddressModel>(context);
}

class BasketModel extends Model{

  static BasketModel of(BuildContext context) =>
      ScopedModel.of<BasketModel>(context);

  List<BasketItem> _items = [];
  List<BasketItem> get items => _items;

  void add(BasketItem item){
    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear(){
    _items.clear();
    notifyListeners();
  }
}

class WashType extends Model {
  WashType({this.wash,this.dry,this.fold});
  String wash;
  String dry;
  String fold;
}

class Clothe extends Model{
  Clothe({ this.clothe, this.white, this.value});
  String clothe;
  double value;
  bool white;

  factory Clothe.fromMap(Map<String, dynamic> map){
    return new Clothe(
        clothe: map['clothe'],
        value: map['value'],
        white: map['white']
    );
  }

  Map<String, dynamic> toJson() => {
    'clothe':clothe,
    'value':value,
    'white':white
  };
}

class BasketItem extends Model{
  BasketItem({
    this.clothe,
    this.current,
    this.white,
    this.id,
    this.price,
    this.drytype,
    this.foldtype,
    this.washtype,
    this.icon
  });

  Icon icon;
  String id;
  String clothe;
  double price;
  double current;
  bool white;
  String washtype;
  String drytype;
  String foldtype;

  factory BasketItem.fromMap(Map<dynamic, dynamic> map, String id){
    return new BasketItem(
      clothe: map['clothe'],
      current: map['current'],
      white: map['white'],
      id: id,
      drytype: map['drytype'],
      foldtype: map['foldtype'],
      price: map['price'],
      washtype: map['washtype'],
    );
  }

  Map<String, dynamic> toJson() => {
    'clothe': clothe,
    'current': current,
    'white': white,
    'id': id,
    'drytype': drytype,
    'foldtype': foldtype,
    'price': price,
    'washtype': washtype
  };
}
