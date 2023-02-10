import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:uuid/uuid.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    init();

    on<OrderAdded>(_orderAddedToState);
    on<OrderUpdated>(_orderUpdatedToState);
  }

  Future<void> init() async {
    await _restore();
  }

  void addOrder(Order order) {
    add(OrderAdded(order));
  }

  void updateOrder(Order order) {
    add(OrderUpdated(order));
  }

  Future<void> _save() async {
    final box = await Hive.openBox('ORDER');
    await box.put('orders', state.orders.map((item) => item.toJson()).toList());
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('ORDER');

    if (box.containsKey('orders')) {
      final items = box.get('orders');

      Map<String, dynamic> _parser(dynamic hiveMap) {
        final jsonString = jsonEncode(hiveMap);
        return jsonDecode(jsonString);
      }

      if (items is List) {
        final newItems =
            items.map((item) => Order.fromJson(_parser(item))).toList();

        emit(state.copyWith(orders: newItems, key: Uuid().v1()));
      }
    }
  }

  void _orderAddedToState(OrderAdded event, Emitter<OrderState> emit) {
    emit(state.add(event.order));
    _save();
  }

  void _orderUpdatedToState(OrderUpdated event, Emitter<OrderState> emit) {
    emit(state.updateOrder(event.order));
    _save();
  }
}
