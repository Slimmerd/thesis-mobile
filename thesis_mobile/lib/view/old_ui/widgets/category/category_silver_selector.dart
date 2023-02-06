import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/utils/colors.dart';

class CategorySliverSelector extends StatefulWidget {
  final List<Category> categories;
  final AutoScrollController controller;

  CategorySliverSelector({
    Key? key,
    required this.categories,
    required this.controller,
  }) : super(key: key);

  @override
  _CategorySliverSelectorState createState() => _CategorySliverSelectorState();
}

class _CategorySliverSelectorState extends State<CategorySliverSelector> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeader(
        widget: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (_, int index) {
              return GestureDetector(
                onTap: () async {
                  await widget.controller.scrollToIndex(index,
                      preferPosition: AutoScrollPosition.begin);
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.Dorian,
                      borderRadius: BorderRadius.circular(14)),
                  child: Text(widget.categories[index].name),
                ),
              );
            }),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: AppColors.Cloud, width: double.infinity, child: widget);
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
