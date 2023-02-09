import 'package:thesis_mobile/core/model/product.dart';

class Category {
  int id;
  String name;
  List<Product> products;

  Category({required this.id, required this.name, required this.products});

  Category.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        products = json['products'];

  Category.fromApiJson(Map json, List<Product> products)
      : id = json['id'],
        name = json['name'],
        products = List<Product>.from(
            json['products'].map((x) => Product.fromApiJson(x, products)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'products': products,
      };
}
