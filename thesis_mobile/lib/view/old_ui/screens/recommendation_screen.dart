import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_replace.dart';
import 'package:thesis_mobile/view/old_ui/screens/checkout_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        List<Product> products = [...state.randomFive, ...state.randomFive];
        return Scaffold(
          appBar: AppBar(
            title: Text('Recommendations'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: products
                          .map((e) => ProductCard(
                                product: e,
                                pright: 0,
                              ))
                          .toList(),
                    ),
                  ),
                ]),
              ),
              Container(
                  width: double.infinity,
                  // height: window.viewPadding.bottom + 105,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.Cloud,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: ElevatedButton(
                      onPressed: () =>
                          customPageReplace(context, CheckoutScreen()),
                      child: Text('Continue',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.Graphite)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.Dorian,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(14.0),
                          ),
                          elevation: 0,
                          minimumSize: Size(225, 48),
                          maximumSize: Size(425, 53),
                          textStyle: TextStyle(fontSize: 18))))
            ],
          ),
        );
      },
    );
  }
}
