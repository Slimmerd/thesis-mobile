part of 'achievements_bloc.dart';

class AchievementsState extends Equatable {
  final String key;
  final List<Achievement> achieved;
  final List<Achievement> notAchieved;
  final List<Achievement> co2Saved;
  final List<Achievement> treesSaved;
  final List<Achievement> ordersMade;

  AchievementsState(
      {this.achieved = const [],
      this.notAchieved = const [],
      this.co2Saved = const [],
      this.treesSaved = const [],
      this.ordersMade = const [],
      this.key = ''});

  AchievementsState update(StatisticsState stats) {
    List<Achievement> newAchieved = [];
    List<Achievement> newNotAchieved = [];

    for (var achievement in co2Saved) {
      if (stats.co2Saved >= achievement.amount) {
        newAchieved.add(achievement);
      } else {
        newNotAchieved.add(achievement);
      }
    }

    for (var achievement in treesSaved) {
      if (stats.treesSaved >= achievement.amount) {
        newAchieved.add(achievement);
      } else {
        newNotAchieved.add(achievement);
      }
    }

    for (var achievement in ordersMade) {
      if (stats.ordersMade >= achievement.amount) {
        newAchieved.add(achievement);
      } else {
        newNotAchieved.add(achievement);
      }
    }

    return copyWith(
        achieved: newAchieved, notAchieved: newNotAchieved, key: Uuid().v1());
  }

  AchievementsState copyWith(
      {List<Achievement>? achieved,
      List<Achievement>? notAchieved,
      List<Achievement>? co2Saved,
      List<Achievement>? treesSaved,
      List<Achievement>? ordersMade,
      String? key}) {
    return AchievementsState(
        achieved: achieved ?? this.achieved,
        notAchieved: notAchieved ?? this.notAchieved,
        co2Saved: co2Saved ?? this.co2Saved,
        ordersMade: ordersMade ?? this.ordersMade,
        treesSaved: treesSaved ?? this.treesSaved,
        key: key ?? this.key);
  }

  @override
  List<Object?> get props => [achieved, co2Saved, treesSaved, ordersMade, key];
}
