import 'package:thesis_mobile/core/model/category.dart';

class ParentCategory {
  int id;
  String name;
  String image;
  bool big;
  List<Category> categories;

  ParentCategory(
      {required this.id,
      required this.name,
      required this.categories,
      required this.image,
      this.big = false});

  ParentCategory.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        big = json['big'],
        categories = json['categories'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'big': big,
        'categories': categories,
      };
}
