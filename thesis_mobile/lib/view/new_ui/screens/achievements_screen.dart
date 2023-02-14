import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesis_mobile/core/bloc/achievements/achievements_bloc.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/view/new_ui/widgets/achievement_card.dart';

class AchievementsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] AchievementsScreen');

    return BlocBuilder<AchievementsBloc, AchievementsState>(
      builder: (context, state) {
        final statsContext = BlocProvider.of<StatisticsBloc>(context);
        AchievementsBloc ctx = context.read<AchievementsBloc>();
        ctx.updateAchievement(statsContext.state);
        return Scaffold(
          appBar: AppBar(title: Text('Achievements')),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
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
                )
              ]),
        );
      },
    );
  }
}
