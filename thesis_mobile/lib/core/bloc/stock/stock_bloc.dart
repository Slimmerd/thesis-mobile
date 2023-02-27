import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thesis_mobile/core/api/internal_api.dart';
import 'package:thesis_mobile/core/model/category.dart';
import 'package:thesis_mobile/core/model/parent_category.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:uuid/uuid.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc() : super(StockState()) {
    init();
    on<StockEvent>((event, emit) {});
  }

  Future<void> init() async {
    await _restore();
  }

  Future<void> _restore() async {
    List<Product> products = await InternalApiService.fetchProducts();
    List<Category> categories =
        await InternalApiService.fetchCategories(products);
    List<ParentCategory> parentCategories =
        await InternalApiService.fetchParentCategory(categories);

    emit(state.copyWith(
        products: products,
        categories: categories,
        parentCategories: parentCategories,
        key: Uuid().v1()));
  }
}
