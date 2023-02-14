import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'task_manager_event.dart';
part 'task_manager_state.dart';

class TaskManagerBloc extends Bloc<TaskManagerEvent, TaskManagerState> {
  TaskManagerBloc() : super(TaskManagerState()) {
    init();
    on<TaskInitUID>(_taskInitUIDToState);
    on<TaskUpdateStage>(_taskUpdateStageToState);
    on<TaskAddOrder>(_taskAddOrderToState);
    on<TaskAddLog>(_taskAddLogToState);
  }

  Future<void> init() async {
    await _restore();
  }

  Future<void> _save() async {
    final Box taskManagerBox = await Hive.openBox('TASK_MANAGER');
    await taskManagerBox.put('uID', state.uID);
    await taskManagerBox.put('stage', state.stage.index);
    await taskManagerBox.put('ordersInStage', state.ordersInStage);
    await taskManagerBox.put('actions', state.actions);
  }

  Future<void> _restore() async {
    final Box taskManagerBox = await Hive.openBox('TASK_MANAGER');

    if (taskManagerBox.containsKey('uID') &&
        taskManagerBox.containsKey('stage') &&
        taskManagerBox.containsKey('ordersInStage') &&
        taskManagerBox.containsKey('actions')) {
      final uID = taskManagerBox.get('uID');
      final stage = taskManagerBox.get('stage');
      final ordersInStage = taskManagerBox.get('ordersInStage');
      final actions = taskManagerBox.get('actions');

      emit(state.copyWith(
          uID: uID,
          stage: TaskManagerStage.values[stage],
          ordersInStage: ordersInStage,
          actions: actions,
          key: Uuid().v1()));
    }
  }

  void initUIDTask() {
    add(TaskInitUID());
  }

  void updateStageTask(TaskManagerStage stage) {
    add(TaskUpdateStage(stage));
  }

  void addOrderTask() {
    add(TaskAddOrder());
  }

  void addLogTask(String log) {
    add(TaskAddLog(log));
  }

  void _taskInitUIDToState(TaskInitUID event, Emitter<TaskManagerState> emit) {
    emit(state.initUID());
    _save();
  }

  void _taskUpdateStageToState(
      TaskUpdateStage event, Emitter<TaskManagerState> emit) {
    emit(state.updateStage(event.stage));
    _save();
  }

  void _taskAddOrderToState(
      TaskAddOrder event, Emitter<TaskManagerState> emit) {
    emit(state.addOrder());
    _save();
  }

  void _taskAddLogToState(TaskAddLog event, Emitter<TaskManagerState> emit) {
    emit(state.addLog(event.log));
    _save();
  }
}
