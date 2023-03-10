import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/model/parent_category.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/utils/typography.dart';
import 'package:thesis_mobile/view/new_ui/screens/category_screen.dart';

class CategoryCard extends StatelessWidget {
  final bool big;
  final ParentCategory parentCategory;

  const CategoryCard(
      {super.key, this.big = false, required this.parentCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => customPagePush(
          context,
          CategoryScreen(
            name: parentCategory.name,
            categories: parentCategory.categories,
          )),
      child: Container(
        width: big ? 220.w : 105.w,
        height: 105,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
            ],
            image: DecorationImage(
                image: AssetImage(parentCategory.image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver)),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            parentCategory.name,
            style: NewTypography.r16700.apply(color: AppColors.cloud),
          ),
        ),
      ),
    );
  }
}
