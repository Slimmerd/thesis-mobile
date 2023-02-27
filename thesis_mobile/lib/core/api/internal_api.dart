import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:thesis_mobile/core/model/achievement.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/core/model/parent_category.dart';
import 'package:thesis_mobile/core/model/product.dart';

class InternalApiService {
  static Future<List<Product>> fetchProducts() async {
    try {
      dynamic response = await rootBundle.loadString('assets/data/data.json');
      dynamic decodedResponse = jsonDecode(response);

      List<Product> products = List<Product>.from(
          decodedResponse['products'].map((x) => Product.fromJson(x)));

      return products;
    } catch (e) {
      print('[CATCH] $e');
      return [];
    }
  }

  static Future<List<Category>> fetchCategories(List<Product> products) async {
    try {
      dynamic response = await rootBundle.loadString('assets/data/data.json');
      dynamic decodedResponse = jsonDecode(response);

      return List<Category>.from(decodedResponse['categories']
          .map((x) => Category.fromApiJson(x, products)));
    } catch (e) {
      print('[CATCH] $e');
      return [];
    }
  }

  static Future<List<ParentCategory>> fetchParentCategory(
      List<Category> categories) async {
    try {
      dynamic response = await rootBundle.loadString('assets/data/data.json');
      dynamic decodedResponse = jsonDecode(response);

      return List<ParentCategory>.from(decodedResponse['parentCategories']
          .map((x) => ParentCategory.fromApiJson(x, categories)));
    } catch (e) {
      print('[CATCH] $e');
      return [];
    }
  }

  static Future<List<Achievement>> fetchAchievements(String type) async {
    try {
      dynamic response =
          await rootBundle.loadString('assets/data/achievements.json');
      dynamic decodedResponse = jsonDecode(response);

      return List<Achievement>.from(
          decodedResponse[type].map((x) => Achievement.fromJson(x)));
    } catch (e) {
      print('[CATCH] $e');
      return [];
    }
  }
}
