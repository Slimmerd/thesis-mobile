import 'package:flutter/material.dart';

class DefaultData {
  // Order
  static int waitingTime = 30;

  static final List<Map<String, dynamic>> imgList = [
    {
      'category': 1,
      'img': 'assets/asian.jpg',
      'text': 'New food from asia',
    },
    {
      'category': 9,
      'img': 'assets/coffee.jpg',
      'text': 'Have a good start',
    },
    {
      'category': 7,
      'img': 'assets/bakery.jpg',
      'text': 'New items in bakery',
    },
    {
      'category': 21,
      'img': 'assets/fruits.jpg',
      'text': 'Fresh fruits to keep healthy life'
    },
  ];

  static Map<int, String> hoursRange2 = {
    0: "00:00-02:00",
    2: "02:00-04:00",
    4: "04:00-06:00",
    6: "06:00-08:00",
    8: "08:00-10:00",
    10: "10:00-12:00",
    12: "12:00-14:00",
    14: "14:00-16:00",
    16: "16:00-18:00",
    18: "18:00-20:00",
    20: "20:00-22:00",
    22: "22:00-00:00"
  };

  static Map<int, String> hoursRange1 = {
    0: "00:00-01:00",
    1: "01:00-02:00",
    2: "02:00-03:00",
    3: "03:00-04:00",
    4: "04:00-05:00",
    5: "05:00-06:00",
    6: "06:00-07:00",
    7: "07:00-08:00",
    8: "08:00-09:00",
    9: "09:00-10:00",
    10: "10:00-11:00",
    11: "11:00-12:00",
    12: "12:00-13:00",
    13: "13:00-14:00",
    14: "14:00-15:00",
    15: "15:00-16:00",
    16: "16:00-17:00",
    17: "17:00-18:00",
    18: "18:00-19:00",
    19: "19:00-20:00",
    20: "20:00-21:00",
    21: "21:00-22:00",
    22: "22:00-23:00",
    23: "23:00-00:00",
  };

  static List<Map<String, dynamic>> onboardingSlider = [
    {
      'icon': Icons.eco,
      'text':
          'Hello, this is application is used in research about impact of interface design decisions on people\'s consumption'
    },
    {
      'icon': Icons.shopping_cart,
      'text':
          'The goal is to establish dependency of user interface design on consumption. Also test hypotheses related to reducing environmental impact and consumption'
    },
    {
      'icon': Icons.bug_report,
      'text':
          'As a tester you need explore both versions of application and make 3 orders in each of them. Don\'t forget to view all sections of the application, not only related to the list of products and orders'
    },
    {
      'icon': Icons.person,
      'text':
          'When you complete the task you can transfer to the next stage in profile screen'
    },
    {
      'icon': Icons.quiz,
      'text':
          'At the end you will have to complete questionare about two applications that you\'ve used'
    },
  ];
}
