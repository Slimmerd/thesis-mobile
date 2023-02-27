import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';
import 'package:thesis_mobile/core/bloc/cart/cart_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/regex_helpers.dart';
import 'package:thesis_mobile/utils/volume_type_parser.dart';
import 'package:thesis_mobile/view/old_ui/widgets/components/custom_counter.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  final List<Product> recommendations;
  const ProductScreen(
      {super.key, required this.product, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] ProductScreen ${product.id}');
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (cartContext, cartState) {
          CartBloc cart = cartContext.read<CartBloc>();
          var addToCartPrice = Money.fromInt(product.price, code: 'GBP')
              .format('#,###,###.00 S')
              .toString()
              .replaceAll(regexRemoveZero, '');

          var productVolume =
              product.volume >= 1000 ? product.volume / 1000 : product.volume;
          var volumeType = product.volume >= 1000
              ? volumeTypeParserBig(product.volumeType)
              : volumeTypeParserSmall(product.volumeType);
          String productInfo =
              '${productVolume.toString().replaceAll(regexRemoveZero, '')} $volumeType';

          return Container(
              decoration: const BoxDecoration(
                color: AppColors.cloud,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: Column(children: [
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                            cacheHeight: 768,
                            cacheWidth: 768,
                          )),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${product.name}, $productInfo',
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.headline3),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(addToCartPrice,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      softWrap: true),
                                ),
                                Container(
                                    child: cartState.has(product.id)
                                        ? CustomCounter(
                                            height: 48,
                                            onChanged: (int quantity) {
                                              if (quantity > 0) {
                                                cart.updateQuantity(
                                                    product.id, quantity);

                                                taskContext.addLogTask(
                                                    '[OLDUI][UPDATED] Product: ${product.id}, pc: $quantity');
                                              } else {
                                                cart.removeFromCart(product.id);
                                                taskContext.addLogTask(
                                                    '[OLDUI][REMOVED] Product ${product.id}');
                                              }
                                            },
                                            quantity: cartState.count(product),
                                          )
                                        :
                                        // Add cart button
                                        ElevatedButton(
                                            onPressed: () {
                                              cart.addToCart(CartProduct(
                                                  product: product,
                                                  quantity: 1));
                                              taskContext.addLogTask(
                                                  '[OLDUI][ADDED] Product: ${product.id}');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.mintGreen,
                                                shape:
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                ),
                                                elevation: 0,
                                                minimumSize: const Size(150, 43),
                                                textStyle:
                                                    const TextStyle(fontSize: 18)),
                                            child: const FittedBox(
                                              child: Text('Add to cart'),
                                            ),
                                          ))
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Per 100 gramms',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              '${product.perHundredGrams.fat}'),
                                          const Text('fat'),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Text(
                                              '${product.perHundredGrams.carbs}'),
                                          const Text('carbs')
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Text(
                                              '${product.perHundredGrams.protein}'),
                                          const Text('protein')
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Text(
                                              '${product.perHundredGrams.kcal}'),
                                          const Text('kcal')
                                        ],
                                      ),
                                    ],
                                  )
                                ]),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Best before, storage',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '${product.description.shelfLife}, ${product.description.storageConditions}')
                                  ]),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Ingredients',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(product.description.ingredients)
                                  ]),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Manufacturer, country',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      product.description.manufacturer,
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Brand',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(product.description.brand)
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        height: 220,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You may also like',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                  child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: recommendations.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(
                                      product: recommendations[index]);
                                },
                              ))
                            ]),
                      )
                    ],
                  ),
                ),
              ]));
        },
      ),
    );
  }
}
