import 'package:flutter/material.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';

class PhotosModel {
  PhotosModel({this.isSelected, this.icon});
  bool isSelected;
  Widget icon;
}

List<PhotosModel> yourPhotoList = [
  new PhotosModel(
      icon: Icon(
        MyFlutterApp.shirt_1,
        size: 100.0,
      ),
      isSelected: false),
  new PhotosModel(
      icon: new Image.network(
        "https://images.bewakoof.com/t540/up-in-smoke-typography-half-sleeve-t-shirt-men-s-printed-t-shirts-1513764488.jpg",
        fit: BoxFit.fill,
      ),
      isSelected: false),
  new PhotosModel(
      icon: Icon(
        MyFlutterApp.shirt_1,
        size: 100.0,
      ),
      isSelected: false),
  new PhotosModel(
      icon: new Image.network(
        "https://images.bewakoof.com/t540/up-in-smoke-typography-half-sleeve-t-shirt-men-s-printed-t-shirts-1513764488.jpg",
        fit: BoxFit.fill,
      ),
      isSelected: false),
];
List<PhotosModel> systemPhotoList = [
  new PhotosModel(
      icon: Icon(
        MyFlutterApp.tshirt,
        size: 100.0,
      ),
      isSelected: false),
  new PhotosModel(
      icon: Icon(
        MyFlutterApp.shirt_1,
        size: 100.0,
      ),
      isSelected: false),
  new PhotosModel(
      icon: new Image.network(
        "https://images.bewakoof.com/t540/up-in-smoke-typography-half-sleeve-t-shirt-men-s-printed-t-shirts-1513764488.jpg",
        fit: BoxFit.fill,
      ),
      isSelected: false),
  new PhotosModel(
      icon: Image.network(
          "https://www.unived.in/wp-content/uploads/2018/02/rrunn-evolution-tshirt-men-front-.jpg",
          fit: BoxFit.fill),
      isSelected: false),
  new PhotosModel(
      icon: Icon(
        MyFlutterApp.tshirt,
        size: 100.0,
      ),
      isSelected: false),
  new PhotosModel(
      icon: Image.network(
          "https://www.unived.in/wp-content/uploads/2018/02/rrunn-evolution-tshirt-men-front-.jpg",
          fit: BoxFit.fill),
      isSelected: false),
];
