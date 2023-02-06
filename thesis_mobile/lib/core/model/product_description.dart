class ProductDescription {
  int id;
  String ingredients;
  String shelfLife;
  String storageConditions;
  String manufacturer;
  String brand;

  ProductDescription(
      {required this.id,
      required this.ingredients,
      required this.shelfLife,
      required this.storageConditions,
      required this.manufacturer,
      required this.brand});

  ProductDescription.fromJson(Map json)
      : id = json['id'],
        ingredients = json['ingredients'],
        shelfLife = json['shelfLife'],
        storageConditions = json['storageConditions'],
        manufacturer = json['manufacturer'],
        brand = json['brand'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'ingredients': ingredients,
        'shelfLife': shelfLife,
        'storageConditions': storageConditions,
        'manufacturer': manufacturer,
        'brand': brand,
      };
}
