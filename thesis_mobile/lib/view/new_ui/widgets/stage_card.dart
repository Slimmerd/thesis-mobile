import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/questionnaire/finish_screen.dart';

class StageCard extends StatelessWidget {
  const StageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerBloc, TaskManagerState>(
      builder: (context, state) {
        TaskManagerBloc task = context.read<TaskManagerBloc>();
        return Container(
          height: (state.ordersInStage >= 3 ||
                  state.stage == TaskManagerStage.finish)
              ? 220
              : 180,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: state.ordersInStage >= 3
                  ? AppColors.mintGreen
                  : AppColors.lightRed,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(17, 54, 41, 0.1), blurRadius: 10)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Second app stage',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.apply(color: AppColors.cloud)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      'To complete this stage you have to make 3 orders and explore the app. \nWe want you to check achievements and statistics screen. \nAlso, it would be great if you will try to experiment with delivery methods',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.apply(color: AppColors.cloud)),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: state.stage == TaskManagerStage.finish
                  ? ElevatedButton(
                      onPressed: () =>
                          customPagePushRemove(context, const FinishScreen()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dorian,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        elevation: 0,
                        minimumSize: const Size(335, 43),
                      ),
                      child: const Text('Finish',
                          style: TextStyle(
                              fontSize: 18, color: AppColors.graphite)))
                  : state.ordersInStage >= 3
                      ? ElevatedButton(
                          onPressed: () {
                            task.addLogTask(
                                '[NEWUI][STAGE] Transfer to FINISH');

                            task.updateStageTask(TaskManagerStage.finish);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dorian,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            elevation: 0,
                            minimumSize: const Size(335, 43),
                          ),
                          child: const Text('Next stage',
                              style: TextStyle(
                                  fontSize: 18, color: AppColors.graphite)))
                      : const SizedBox(),
            )
          ]),
        );
      },
    );
  }
}
