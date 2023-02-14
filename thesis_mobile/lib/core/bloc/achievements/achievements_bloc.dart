import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thesis_mobile/core/api.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/model/achievement.dart';
import 'package:uuid/uuid.dart';

part 'achievements_event.dart';
part 'achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  AchievementsBloc() : super(AchievementsState()) {
    init();
    on<AchievementUpdate>(_achievementUpdateToState);
  }

  Future<void> init() async {
    await _restore();
  }

  Future<void> _restore() async {
    List<Achievement> achievementCo2Saved =
        await ApiService.fetchAchievements('co2Saved');
    List<Achievement> achievementTreesSaved =
        await ApiService.fetchAchievements('treesSaved');
    List<Achievement> achievementOrdersMade =
        await ApiService.fetchAchievements('order');

    emit(state.copyWith(
        co2Saved: achievementCo2Saved,
        treesSaved: achievementTreesSaved,
        ordersMade: achievementOrdersMade,
        key: Uuid().v1()));
  }

  void updateAchievement(StatisticsState stats) {
    add(AchievementUpdate(stats));
  }

  void _achievementUpdateToState(
      AchievementUpdate event, Emitter<AchievementsState> emit) {
    emit(state.update(event.stats));
  }
}
