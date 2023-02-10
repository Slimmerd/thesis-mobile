import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/delivery_type.dart';
import 'package:thesis_mobile/core/model/order_status.dart';

class Order {
  int id;
  List<CartProduct> products;
  OrderStatus status;
  int subTotal;
  int deliveryPrice;
  int serviceFee;
  int total;
  Address address;
  String comment;
  DateTime createdAt;
  DateTime? deliveredAt;
  int? review;
  int waitingTime;
  DeliveryType deliveryType;
  List<DateTime>? deliveryWindow;
  int ecoLevel;

  Order(
      {Key? key,
      required this.id,
      required this.products,
      this.status = OrderStatus.waitingWarehouse,
      required this.subTotal,
      required this.deliveryPrice,
      required this.serviceFee,
      required this.total,
      required this.address,
      this.comment = "",
      this.review,
      this.waitingTime = 15,
      this.ecoLevel = 0,
      required this.deliveryType,
      this.deliveryWindow,
      required this.createdAt});

  Order.fromJson(Map json)
      : id = json['id'],
        products = List<CartProduct>.from(
            json['products'].map((e) => CartProduct.fromJson(e))),
        subTotal = json['subTotal'],
        status = OrderStatus.values[json['status']],
        waitingTime = json['waitingTime'],
        deliveryPrice = json['deliveryPrice'],
        serviceFee = json['serviceFee'],
        total = json['total'],
        review = json['review'],
        address = Address.fromJson(json['address']),
        createdAt = DateTime.parse(json['createdAt']),
        deliveredAt = DateTime.tryParse(json['deliveredAt'] ?? ''),
        deliveryType = DeliveryType.values[json['deliveryType']],
        deliveryWindow = json['deliveryWindow'],
        ecoLevel = json['ecoLevel'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'products': products.map((e) => e.toJson()).toList(),
        'subTotal': subTotal,
        'status': status.index,
        'waitingTime': waitingTime,
        'createdAt': createdAt.toIso8601String(),
        'review': review,
        'deliveryPrice': deliveryPrice,
        'serviceFee': serviceFee,
        'total': total,
        'address': address.toJson(),
        'deliveredAt': deliveredAt?.toIso8601String(),
        'deliveryType': deliveryType.index,
        'deliveryWindow': deliveryWindow,
        'ecoLevel': ecoLevel,
        'comment': comment,
      };
}
