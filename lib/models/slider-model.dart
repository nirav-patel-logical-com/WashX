class SliderModel {
  final String image;
  final String title;
  final String subTitle;
  final String link;
  final String color;

 const SliderModel({this.image, this.title, this.subTitle, this.link, this.color});

//  factory SliderModel.fromJson(Map<String, dynamic> json) {
//    return SliderModel(
//      image: json['image'] as String,
//      title: json['title'] as String,
//      subTitle: json['subTitle'] as String,
//      link: json['link'] as String,
//    );
//  }

}
