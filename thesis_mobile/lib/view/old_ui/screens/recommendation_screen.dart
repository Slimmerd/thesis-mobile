import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_replace.dart';
import 'package:thesis_mobile/view/old_ui/screens/checkout_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] RecommendationScreen');

    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        List<Product> products = [...state.randomFive, ...state.randomFive];
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recommendations'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.cloud,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: ElevatedButton(
                      onPressed: () =>
                          customPageReplace(context, const CheckoutScreen()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.dorian,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          elevation: 0,
                          minimumSize: const Size(225, 48),
                          maximumSize: const Size(425, 53),
                          textStyle: const TextStyle(fontSize: 18)),
                      child: const Text('Continue',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.graphite))))
            ],
          ),
        );
      },
    );
  }
}
