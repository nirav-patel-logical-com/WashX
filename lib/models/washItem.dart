import 'package:wash_x/custom/customWardrobeItem.dart.dart';

class WashItem {
  WashItem(
      {this.id,
      this.basket,
      this.itemCount,
      this.brand,
      this.category,
      this.description,
      this.name,
      this.price,
      this.color,
      this.image,
      this.isModified,
      this.pattern,
      this.care});

  String id;
  String basket;
  int itemCount;
  String name;
  String brand;
  String price;
  String image;
  String label;
  String description;
  String color;
  String pattern;
  bool isModified;
  bool isExpanded = false;
  CustomWardrobeExpansionTileState state =
      new CustomWardrobeExpansionTileState();
  String category;
  List<int> care;
}

List<WashItem> wardrobeItemList = [
  new WashItem(
      itemCount: 6,
      image:
          "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
      brand: "Adidas",
      category: "Skirt",
      basket: "My Basket",
      color: "Yellow",
      description: "This is a nice skirt",
      isModified: false,
      id: "ABTGG7889NBB",
      name: "Adi-Skirt",
      pattern: "Vertical Stripes",
      price: "20.0",
      care: [0, 2, 3]),
  new WashItem(
    itemCount: 2,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    basket: "Work Basket",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoShirt",
    pattern: "Plain",
    price: "10.0",
    care: [1, 3],
  ),
  new WashItem(
    itemCount: 0,
    image:
        "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
    brand: "Adidas",
    basket: "New Basket",
    category: "Skirt",
    color: "Yellow",
    description: "This is a nice skirt",
    isModified: false,
    id: "ABTGG7889NBB",
    name: "Adi-Shirt",
    pattern: "Horizontal Stripes",
    price: "20.0",
    care: [0, 2, 1],
  ),
  new WashItem(
    itemCount: 4,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    basket: "HomeBasket",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoloShirt",
    pattern: "Plain",
    price: "50.0",
    care: [0, 2, 3],
  ),
  new WashItem(
    itemCount: 0,
    image:
        "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
    brand: "Adidas",
    category: "Pants",
    color: "Yellow",
    description: "This is a nice pants",
    isModified: true,
    id: "ABTGG7889NBB",
    name: "fav-jeans",
    pattern: "Vertical Stripes",
    price: "20.0",
    care: [0, 2, 3],
  ),
  new WashItem(
    itemCount: 2,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoShirt",
    pattern: "Plain",
    price: "10.0",
    care: [0, 2],
  ),
];
