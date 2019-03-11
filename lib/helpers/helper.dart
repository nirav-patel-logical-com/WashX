import 'package:wash_x/models/model.dart';
import 'my_flutter_app_icons.dart';

const Map<String, dynamic> icons = {
  'Dress': MyFlutterApp.dress,
  'Pants': MyFlutterApp.pants,
  'Polo': MyFlutterApp.polo,
  'T-Shirt': MyFlutterApp.tshirt,
  'Skirt': MyFlutterApp.skirt,
  'Suit': MyFlutterApp.suit,
  'Shorts': MyFlutterApp.shorts,
  'Slippers': MyFlutterApp.slippers,

};

List<BasketItem> clothes = <BasketItem>[
  new BasketItem(clothe: 'Dress', price: 10.0),
  new BasketItem(clothe: 'Pants', price: 11.0),
  new BasketItem(clothe: 'Polo', price: 12.0),
  new BasketItem(clothe: 'T-Shirt', price: 13.0),
  new BasketItem(clothe: 'Skirt', price: 14.0),
  new BasketItem(clothe: 'Suit', price: 15.0),
  new BasketItem(clothe: 'Shorts', price: 16.0),
  new BasketItem(clothe: 'Slippers', price: 16.0)
];