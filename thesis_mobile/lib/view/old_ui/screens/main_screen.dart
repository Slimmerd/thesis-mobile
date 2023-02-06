import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/utils/default_data.dart';
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
  late AddressState _addressState;

  @override
  void initState() {
    _scrollController = ScrollController();
    _addressState = BlocProvider.of<AddressBloc>(context).state;
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
          title: TitleAddressSelect(
            addressState: _addressState,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          // controller: _scrollController,
          // shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                  width: double.infinity,
                  height: 245.h,
                  child: PromotionsCarousel()),
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
                itemCount: DefaultData.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(product: DefaultData.products[index]);
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
                children: DefaultData.parentCategories
                    .map((e) => CategoryCard(
                          parentCategory: e,
                        ))
                    .toList(),
              ),
            ),
          ],
        ));
  }
}
