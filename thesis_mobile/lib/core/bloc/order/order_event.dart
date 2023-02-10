part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderAdded extends OrderEvent {
  final Order order;

  const OrderAdded(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderAdded { order: $order }';
}

class OrderUpdated extends OrderEvent {
  final Order order;

  const OrderUpdated(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderUpdated { order: $order }';
}
