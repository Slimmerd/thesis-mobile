import 'package:thesis_mobile/core/model/product.dart';

class CartProduct {
  Product product;
  int quantity;

  bool get isSingle => quantity == 1;

  int get totalPrice => product.price * quantity;

  CartProduct({
    required this.product,
    this.quantity = 1,
  });

  CartProduct.fromJson(Map json)
      : product = Product.fromJson(json['product']),
        quantity = json['quantity'].toInt();

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };
}
