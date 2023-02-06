import 'package:thesis_mobile/core/model/per_hundred_grams.dart';
import 'package:thesis_mobile/core/model/product_description.dart';
import 'package:thesis_mobile/core/model/volume_type.dart';

class Product {
  int id;
  String name;
  String image;
  int volume;
  int price;
  VolumeType volumeType;
  ProductDescription description;
  PerHundredGrams perHundredGrams;

  Product({
    this.id = 1,
    this.name = "Almond croissant",
    this.image = "assets/pr1.jpeg",
    this.price = 100,
    this.volume = 100,
    this.volumeType = VolumeType.grams,
    required this.description,
    required this.perHundredGrams,
  });

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        volume = json['volume'],
        volumeType = VolumeType.values[json['volumeType']],
        price = json['price'],
        description = ProductDescription.fromJson(json['description']),
        perHundredGrams = PerHundredGrams.fromJson(json['perHundredGrams']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'volume': volume,
        'volumeType': volumeType.index,
        'price': price,
        'description': description.toJson(),
        'perHundredGrams': perHundredGrams.toJson()
      };
}
