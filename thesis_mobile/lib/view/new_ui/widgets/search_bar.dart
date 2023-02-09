import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/search_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        customPagePush(
            context,
            SearchScreen(
              categories: [],
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.Dorian,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          children: [
            Text(
              // 'Продукты или категории',
              'Search products',
              style: TextStyle(color: AppColors.GrayPick, fontSize: 16),
            ),
            Spacer(),
            Icon(Icons.search)
          ],
        ),
      ),
    );
  }
}
