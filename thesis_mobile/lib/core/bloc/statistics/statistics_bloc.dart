import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:thesis_mobile/core/model/order.dart';
import 'package:uuid/uuid.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc() : super(StatisticsState()) {
    init();

    on<OrderAdded>(_orderAddedToState);
  }

  Future<void> init() async {
    await _restore();
  }

  void addOrder(Order order) {
    add(OrderAdded(order));
  }

  Future<void> _save() async {
    final box = await Hive.openBox('stats');
    await box.put('co2Saved', state.co2Saved);
    await box.put('treesSaved', state.treesSaved);
    await box.put('ordersMade', state.ordersMade);
  }

  Future<void> _restore() async {
    final box = await Hive.openBox('stats');

    if (box.containsKey('co2Saved')) {
      final co2Saved = box.get('co2Saved');
      final treesSaved = box.get('treesSaved');
      final ordersMade = box.get('ordersMade');

      emit(state.copyWith(
          co2Saved: co2Saved,
          treesSaved: treesSaved,
          ordersMade: ordersMade,
          key: Uuid().v1()));
    }
  }

  void _orderAddedToState(OrderAdded event, Emitter<StatisticsState> emit) {
    emit(state.addOrder(event.order));
    _save();
  }
}
