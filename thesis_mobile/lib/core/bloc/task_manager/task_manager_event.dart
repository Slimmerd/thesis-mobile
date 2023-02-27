part of 'task_manager_bloc.dart';

abstract class TaskManagerEvent extends Equatable {
  const TaskManagerEvent();

  @override
  List<Object> get props => [];
}

class TaskInitUID extends TaskManagerEvent {
  const TaskInitUID();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskInitUID { newUI initialized }';
}

class TaskAddOrder extends TaskManagerEvent {
  const TaskAddOrder();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskAddOrder { Added new order }';
}

class TaskUpdateStage extends TaskManagerEvent {
  final TaskManagerStage stage;

  const TaskUpdateStage(this.stage);

  @override
  List<Object> get props => [stage];

  @override
  String toString() => 'TaskUpdateStage { stage: $stage }';
}

class TaskAddLog extends TaskManagerEvent {
  final String log;

  const TaskAddLog(this.log);

  @override
  List<Object> get props => [log];

  @override
  String toString() => 'TaskAddLog { log: $log }';
}

class TaskSetUploaded extends TaskManagerEvent {
  const TaskSetUploaded();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskSetUploaded { true }';
}
