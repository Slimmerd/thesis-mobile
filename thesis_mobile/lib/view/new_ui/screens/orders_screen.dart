import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:thesis_mobile/core/model/per_hundred_grams.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/core/model/product_description.dart';
import 'package:thesis_mobile/view/new_ui/widgets/order/order_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  //TODO fix
  final Product _product = Product(
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

  List<Order> orders = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    orders = [
      Order(products: [
        CartProduct(product: _product),
        CartProduct(product: _product),
        CartProduct(product: _product)
      ], createdAt: DateTime.now())
    ];

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Заказы',
        ),
      ),
      body: orders.isNotEmpty
          ? ListView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(
                      order: orders[index],
                    );
                  },
                ),
              ],
            )
          : Center(
              child: Text('Нет заказов'),
            ),
    );
  }
}
