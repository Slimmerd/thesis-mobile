part of 'stock_bloc.dart';

class StockState extends Equatable {
  final String key;
  final List<Product> products;
  final List<Category> categories;
  final List<ParentCategory> parentCategories;

  StockState(
      {this.products = const [],
      this.categories = const [],
      this.parentCategories = const [],
      this.key = ''});

  List<Product> get randomFive {
    int min = 0;
    int max = products.length - 1;
    var rnd = new Random();
    List<Product> prods = [];

    for (var i = 0; i <= 5; i++) {
      prods.add(products[min + rnd.nextInt(max - min)]);
    }

    return prods;
  }

  StockState copyWith(
      {String? key,
      List<Product>? products,
      List<Category>? categories,
      List<ParentCategory>? parentCategories}) {
    return StockState(
        products: products ?? this.products,
        categories: categories ?? this.categories,
        parentCategories: parentCategories ?? this.parentCategories,
        key: key ?? this.key);
  }

  @override
  List<Object?> get props => [products, categories, parentCategories, key];
}
