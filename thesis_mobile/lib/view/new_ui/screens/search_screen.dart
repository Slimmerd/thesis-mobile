import 'package:flutter/material.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:thesis_mobile/utils/form_input_style.dart';
import 'package:thesis_mobile/view/new_ui/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final List<Category> categories;

  const SearchScreen({super.key, required this.categories});

//
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> searchResult = [];

  void getProducts(String searchInput) {
    setState(() => searchResult = widget.categories
        .map((element) => element.products.where((ele) =>
            ele.name.toLowerCase().contains(searchInput.toLowerCase())))
        .expand((el) => el)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск продуктов'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: formInputStyle('', 'Наименование продукта'),
              onChanged: (String? value) {
                getProducts(value ?? '0');
              },
            ),
          ),
          searchResult.isEmpty
              ? Center(
                  child: Text('Здесь пусто'),
                )
              : ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchResult.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(product: searchResult[index]);
                  },
                )
        ],
      ),
    );
  }
}
