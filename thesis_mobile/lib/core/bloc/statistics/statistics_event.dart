part of 'statistics_bloc.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

class OrderAdded extends StatisticsEvent {
  final Order order;

  const OrderAdded(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'OrderAdded { order: $order }';
}
