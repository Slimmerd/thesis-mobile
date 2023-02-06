import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
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
  String deliveryType;
  List<DateTime>? deliveryWindow;
  int ecoLevel;

  Order(
      {Key? key,
      this.id = 1,
      required this.products,
      this.status = OrderStatus.delivered,
      this.subTotal = 30000,
      this.deliveryPrice = 30000,
      this.serviceFee = 3000,
      this.total = 60000,
      this.address = const Address(),
      this.comment = "",
      this.review,
      this.waitingTime = 15,
      this.ecoLevel = 0,
      this.deliveryType = "",
      this.deliveryWindow,
      required this.createdAt});

  Order.fromJson(Map json)
      : id = json['id'],
        products = json['products'],
        subTotal = json['subTotal'],
        status = json['status'],
        waitingTime = json['waitingTime'],
        deliveryPrice = json['deliveryPrice'],
        serviceFee = json['serviceFee'],
        total = json['total'],
        review = json['review'],
        address = json['address'],
        createdAt = json['createdAt'],
        deliveredAt = json['deliveredAt'],
        deliveryType = json['deliveryType'],
        deliveryWindow = json['deliveryWindow'],
        ecoLevel = json['ecoLevel'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'products': products,
        'subTotal': subTotal,
        'status': status,
        'waitingTime': waitingTime,
        'createdAt': createdAt,
        'review': review,
        'deliveryPrice': deliveryPrice,
        'serviceFee': serviceFee,
        'total': total,
        'address': address,
        'deliveredAt': deliveredAt,
        'deliveryType': deliveryType,
        'deliveryWindow': deliveryWindow,
        'ecoLevel': ecoLevel,
        'comment': comment,
      };
}
