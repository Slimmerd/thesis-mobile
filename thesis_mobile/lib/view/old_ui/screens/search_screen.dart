import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';
import 'package:thesis_mobile/view/old_ui/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> products;

  const SearchScreen({super.key, required this.products});

//
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> searchResult = [];

  void getProducts(String searchInput) {
    setState(() => searchResult = widget.products
        .where((element) =>
            element.name.toLowerCase().contains(searchInput.toLowerCase()))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] SearcScreen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Search products'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: formInputStyle('', 'Name'),
              onChanged: (String? value) {
                taskContext.addLogTask('[OLDUI][SEARCHED] $value');
                getProducts(value == null || value.length == 0 ? '0' : value);
              },
            ),
          ),
          searchResult.isEmpty
              ? Center(
                  child: Text('Empty'),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: searchResult
                        .map((e) => ProductCard(
                              product: e,
                              pright: 0,
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
