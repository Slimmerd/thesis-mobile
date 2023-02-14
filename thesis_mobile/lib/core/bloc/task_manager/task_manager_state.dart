part of 'task_manager_bloc.dart';

enum TaskManagerStage { onBoarding, oldUI, newUI, finish }

class TaskManagerState extends Equatable {
  final String key;
  final String uID;
  final TaskManagerStage stage;
  final int ordersInStage;
  final List<String> actions;

  TaskManagerState(
      {this.uID = '',
      this.stage = TaskManagerStage.onBoarding,
      this.ordersInStage = 0,
      this.actions = const [],
      this.key = ''});

  TaskManagerState initUID() {
    if (uID.isEmpty) {
      return copyWith(
          uID: (100000 + Random().nextInt((900000 + 1) - 100000)).toString(),
          key: Uuid().v1());
    }
    return copyWith(key: Uuid().v1());
  }

  TaskManagerState updateStage(TaskManagerStage newStage) {
    switch (newStage) {
      case TaskManagerStage.oldUI:
        return copyWith(stage: TaskManagerStage.oldUI, key: Uuid().v1());
      case TaskManagerStage.newUI:
        if (ordersInStage == 3) {
          return copyWith(
              stage: TaskManagerStage.newUI,
              ordersInStage: 0,
              key: Uuid().v1());
        } else {
          return copyWith(key: Uuid().v1());
        }

      case TaskManagerStage.finish:
        if (ordersInStage == 3) {
          return copyWith(
              stage: TaskManagerStage.finish,
              ordersInStage: 0,
              key: Uuid().v1());
        } else {
          return copyWith(key: Uuid().v1());
        }

      default:
        throw Exception('Error on stage change');
    }
  }

  TaskManagerState addLog(String log) {
    return copyWith(actions: [...actions, log], key: Uuid().v1());
  }

  TaskManagerState addOrder() {
    return copyWith(ordersInStage: ordersInStage + 1, key: Uuid().v1());
  }

  TaskManagerState copyWith(
      {String? uID,
      TaskManagerStage? stage,
      int? ordersInStage,
      List<String>? actions,
      String? key}) {
    return TaskManagerState(
        uID: uID ?? this.uID,
        stage: stage ?? this.stage,
        ordersInStage: ordersInStage ?? this.ordersInStage,
        actions: actions ?? this.actions,
        key: key ?? this.key);
  }

  @override
  List<Object?> get props => [uID, stage, ordersInStage, actions, key];
}
