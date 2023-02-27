import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  final List<Product> products;

  const SearchBar({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        customPagePush(
            context,
            SearchScreen(
              products: products,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.dorian,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          children: const [
            Text(
              'Search products',
              style: TextStyle(color: AppColors.grayPick, fontSize: 16),
            ),
            Spacer(),
            Icon(Icons.search)
          ],
        ),
      ),
    );
  }
}
