part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<Order> orders;
  final String key;

  OrderState({
    this.orders = const [],
    this.key = '',
  });

  bool get isEmpty => total == 0;
  bool get notEmpty => total > 0;

  int get latestOrder {
    if (orders.isNotEmpty) {
      return orders.last.id;
    } else {
      return 0;
    }
  }

  int get total {
    int total = 0;

    for (var _ in orders) {
      total += 1;
    }

    return total;
  }

  int indexWhere(Order order) {
    return orders.indexWhere((element) => element.id == order.id);
  }

  Order itemById(int id) {
    return orders.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('No order'),
    );
  }

  bool has(Order order) {
    return indexWhere(order) != -1;
  }

  Order order(int index) => orders[index];

  OrderState reset() => copyWith(
        orders: [],
        key: '',
      );

  OrderState add(Order order) {
    return copyWith(
      orders: [...orders, order],
      key: Uuid().v1(),
    );
  }

  OrderState updateOrder(Order order) {
    if (has(order)) {
      int index = indexWhere(order);
      orders[index] = order;
    }
    return copyWith(key: Uuid().v1());
  }

  OrderState copyWith({
    List<Order>? orders,
    String? key,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      key: key ?? this.key,
    );
  }

  @override
  List<Object?> get props => [orders, key];
}
