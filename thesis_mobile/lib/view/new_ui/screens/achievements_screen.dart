import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/achievements/achievements_bloc.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/view/new_ui/widgets/achievement_card.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  @override
  void initState() {
    final statsContext = BlocProvider.of<StatisticsBloc>(context);
    final achievementContext = BlocProvider.of<AchievementsBloc>(context);
    achievementContext.updateAchievement(statsContext.state);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] AchievementsScreen');

    return BlocBuilder<AchievementsBloc, AchievementsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Achievements')),
          body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Text(
                  'Completed',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: state.achieved
                        .map((e) => AchievementCard(
                              image: e.image,
                              title: e.title,
                            ))
                        .toList(),
                  ),
                ),
                Text(
                  'Locked',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: state.notAchieved
                        .map((e) => AchievementCard(
                              achieved: false,
                              image: e.image,
                              title: e.title,
                            ))
                        .toList(),
                  ),
                )
              ]),
        );
      },
    );
  }
}
