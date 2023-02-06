import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:thesis_mobile/core/bloc/address/address_bloc.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/view/old_ui/widgets/category/category_silver_appbar.dart';
import 'package:thesis_mobile/view/old_ui/widgets/category/category_silver_selector.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class CategoryScreen extends StatefulWidget {
  final String name;
  final List<Category> categories;

  const CategoryScreen(
      {super.key, required this.categories, required this.name});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late AutoScrollController controller;

  bool init = false;

  @override
  void initState() {
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, AddressState state) {
        // if (state.currentAddress == null) {
        //   return Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(
        //         color: AppColors.LightRed,
        //       ),
        //     ),
        //   );
        // }
        return Scaffold(
          body: SafeArea(
              child: CustomScrollView(
            controller: controller,
            slivers: [
              CategorySliverAppBar(
                title: widget.name,
                categories: widget.categories,
              ),
              CategorySliverSelector(
                controller: controller,
                categories: widget.categories,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => AutoScrollTag(
                    index: index,
                    key: ValueKey(index),
                    controller: controller,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              '${widget.categories[index].name}',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: widget.categories[index].products
                                  .map((e) => ProductCard(
                                        product: e,
                                        pright: 0,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  childCount: widget.categories.length,
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
