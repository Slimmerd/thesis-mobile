part of 'achievements_bloc.dart';

abstract class AchievementsEvent extends Equatable {
  const AchievementsEvent();

  @override
  List<Object> get props => [];
}

class AchievementUpdate extends AchievementsEvent {
  final StatisticsState stats;

  const AchievementUpdate(this.stats);

  @override
  List<Object> get props => [stats];

  @override
  String toString() => 'AchievementUpdate { stats: $stats }';
}
