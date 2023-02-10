import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/search_screen.dart';

class CategorySliverAppBar extends StatefulWidget {
  final String title;
  final List<Product> products;

  CategorySliverAppBar({
    Key? key,
    required this.title,
    required this.products,
  }) : super(key: key);

  @override
  _CategorySliverAppBarState createState() => _CategorySliverAppBarState();
}

class _CategorySliverAppBarState extends State<CategorySliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(widget.title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () => customPagePush(
                context,
                SearchScreen(
                  products: widget.products,
                )),
            child: Icon(Icons.search),
          ),
        ),
      ],
      pinned: true,
      backgroundColor: AppColors.Cloud,
    );
  }
}
