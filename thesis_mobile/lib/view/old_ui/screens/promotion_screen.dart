import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/stock/stock_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class PromotionScreen extends StatelessWidget {
  final int categoryID;

  const PromotionScreen({super.key, required this.categoryID});

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] PromotionScreen ${categoryID}');

    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        Category category = state.categories[categoryID];
        List<Product> products = category.products;
        return Scaffold(
          appBar: AppBar(
            title: Text('${category.name}'),
          ),
          body: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
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
            ],
          ),
        );
      },
    );
  }
}
