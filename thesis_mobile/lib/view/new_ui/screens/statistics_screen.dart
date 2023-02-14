import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/statistics/statistics_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/view/new_ui/widgets/statistics/stats_card.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] StatisticsScreen');

    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Statistics')),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                StatsCard(
                  image: 'assets/stats1.jpeg',
                  title: '${state.co2Saved} CO2 saved',
                ),
                StatsCard(
                  image: 'assets/stats2.jpeg',
                  title: '${state.treesSaved} trees saved',
                ),
                StatsCard(
                  image: 'assets/stats3.jpeg',
                  title: '${state.ordersMade} orders were made',
                ),
              ]),
        );
      },
    );
  }
}
