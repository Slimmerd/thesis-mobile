import 'package:flutter/material.dart';

class Address {
  final int id;
  final String flatNumber;
  final String building;
  final String street;
  final String city;
  final String intercom;
  final String floor;

  const Address(
      {Key? key,
      this.id = 1,
      this.flatNumber = "test",
      this.building = "test",
      this.street = "test",
      this.city = "test",
      this.intercom = "test",
      this.floor = "test"});

  Address.fromJson(Map json)
      : id = json['id'],
        flatNumber = json['flatNumber'],
        building = json['building'],
        street = json['street'],
        city = json['city'],
        intercom = json['intercom'],
        floor = json['floor'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'flatNumber': flatNumber,
        'building': building,
        'street': street,
        'city': city,
        'intercom': intercom,
        'floor': floor,
      };
}
