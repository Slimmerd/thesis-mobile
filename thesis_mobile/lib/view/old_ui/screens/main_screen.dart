import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/view/old_ui/widgets/address/title_address_select.dart';
import 'package:thesis_mobile/view/old_ui/widgets/category/category_card.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';
import 'package:thesis_mobile/view/old_ui/widgets/promotions_carousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] MainScreen');

    return Scaffold(appBar: AppBar(
      title: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          return TitleAddressSelect(
            addressState: state,
          );
        },
      ),
    ), body: BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        List<Product> randomFive =
            state.products.isEmpty ? [] : state.randomFive;

        return state.categories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 245.h,
                        child: const PromotionsCarousel()),
                  ),
                  Text(
                    'Picked for you',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: double.infinity,
                    height: 190,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: randomFive.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(product: randomFive[index]);
                      },
                    ),
                  ),
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: state.parentCategories
                          .map((e) => CategoryCard(
                                parentCategory: e,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
      },
    ));
  }
}
