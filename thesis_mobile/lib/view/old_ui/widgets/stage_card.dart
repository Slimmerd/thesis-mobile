import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';

class StageCard extends StatelessWidget {
  const StageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerBloc, TaskManagerState>(
      builder: (context, state) {
        TaskManagerBloc task = context.read<TaskManagerBloc>();
        return Container(
          height: state.ordersInStage >= 3 ? 180 : 100,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: state.ordersInStage >= 3
                  ? AppColors.MintGreen
                  : AppColors.LightRed,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First app stage',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.apply(color: AppColors.Cloud)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'To complete this stage you have to make 3 orders and explore the app',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.apply(color: AppColors.Cloud)),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: state.ordersInStage >= 3
                  ? ElevatedButton(
                      onPressed: () {
                        task.addLogTask(
                            '[OLDUI][STAGE] Stage transfer to newUI');
                        task.updateStageTask(TaskManagerStage.newUI);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.Dorian,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        elevation: 0,
                        minimumSize: Size(335, 43),
                      ),
                      child: Text('Next stage',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.Graphite)))
                  : SizedBox(),
            )
          ]),
        );
      },
    );
  }
}
