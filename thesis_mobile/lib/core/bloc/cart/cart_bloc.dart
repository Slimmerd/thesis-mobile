import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:thesis_mobile/core/model/cart_product.dart';
import 'package:thesis_mobile/core/model/delivery_type.dart';
import 'package:thesis_mobile/core/model/product.dart';
import 'package:uuid/uuid.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    init();

    on<CartAdded>(_cartAddedToState);
    on<CartQuantityUpdated>(_cartUpdatedToState);
    on<CartRemoved>(_cartRemovedToState);
    on<CartCleared>(_cartClearedToState);
    on<CartDeliveryTypeUpdated>(_cartOrderTypeUpdatedToState);
  }

  Future<void> init() async {
    await _restore();
  }

  void addToCart(CartProduct product) {
    add(CartAdded(product));
  }

  void updateQuantity(int productID, int quantity) {
    add(CartQuantityUpdated(productID, quantity));
  }

  void updateDeliveryType(DeliveryType deliveryType) {
    add(CartDeliveryTypeUpdated(deliveryType));
  }

  void removeFromCart(int productID) {
    add(CartRemoved(productID));
  }

  void clearCart() {
    add(CartCleared());
  }

  Future<void> _save() async {
    final box = await Hive.openBox('cart');
    await box.put('items', state.items.map((item) => item.toJson()).toList());
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('cart');

    if (box.containsKey('items')) {
      final items = box.get('items');

      Map<String, dynamic> _parser(dynamic hiveMap) {
        final jsonString = jsonEncode(hiveMap);
        return jsonDecode(jsonString);
      }

      if (items is List) {
        final newItems =
            items.map((item) => CartProduct.fromJson(_parser(item))).toList();

        final newIds = newItems.map((item) => item.product.id).toList();

        emit(state.copyWith(ids: newIds, items: newItems, key: Uuid().v1()));
      }
    }
  }

  void _cartAddedToState(CartAdded event, Emitter<CartState> emit) {
    emit(state.add(event.product));
    _save();
  }

  void _cartUpdatedToState(CartQuantityUpdated event, Emitter<CartState> emit) {
    emit(state.updateQuantity(event.productID, event.quantity));
    _save();
  }

  void _cartOrderTypeUpdatedToState(
      CartDeliveryTypeUpdated event, Emitter<CartState> emit) {
    emit(state.updateOrderType(event.deliveryType));
    _save();
  }

  void _cartRemovedToState(CartRemoved event, Emitter<CartState> emit) {
    emit(state.remove(event.productID));
    _save();
  }

  void _cartClearedToState(CartCleared event, Emitter<CartState> emit) {
    emit(state.reset());
    _save();
  }
}
