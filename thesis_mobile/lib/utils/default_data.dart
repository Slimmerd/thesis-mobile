import 'package:thesis_mobile/core/model/address.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/core/model/delivery_type.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/core/model/parent_category.dart';
import 'package:thesis_mobile/core/model/per_hundred_grams.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/core/model/product_description.dart';

class DefaultData {
  static final Product _product = Product(
      description: ProductDescription(
          id: 1,
          ingredients: "Potato",
          shelfLife: "3 days",
          storageConditions: "In trash can",
          manufacturer: "Aboba Consumers",
          brand: "Bishkek"),
      perHundredGrams: PerHundredGrams(
        id: 1,
        fat: 32,
        carbs: 30,
        protein: 221,
        kcal: 123,
      ));
  static List<Product> products = [
    _product,
    _product,
    _product,
    _product,
    _product
  ];

//Category
  static final Category _category =
      Category(id: 1, name: "Bakery", products: products);
  static List<Category> categories = [
    _category,
    _category,
    _category,
    _category,
    _category
  ];
  static final ParentCategory _parentCategory1 = ParentCategory(
      id: 1, name: "test", categories: categories, image: "assets/pr1.jpeg");
  static final ParentCategory _parentCategory2 = ParentCategory(
      id: 1,
      name: "test",
      categories: categories,
      image: "assets/img1.jpeg",
      big: true);

  static List<ParentCategory> parentCategories = [
    _parentCategory2,
    _parentCategory1,
    _parentCategory1,
    _parentCategory2,
    _parentCategory1,
    _parentCategory1,
    _parentCategory1,
  ];

  // Order
  static final CartProduct _cartProduct = CartProduct(product: _product);

  static final Order order = Order(products: [
    _cartProduct,
    _cartProduct,
    _cartProduct
  ], deliveryWindow: [
    DateTime.now().subtract(Duration(hours: 1)),
    DateTime.now()
  ], createdAt: DateTime.now());

  static int waitingTime = 30;
  static Address address = Address();
  DeliveryType deliveryType = DeliveryType.asap;
}
