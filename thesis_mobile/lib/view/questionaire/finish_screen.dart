import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finish stage'),
      ),
      body: BlocBuilder<TaskManagerBloc, TaskManagerState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'You have completed practical part of research. For now you will have to complete questionaire using Google Forms. Unique identifier below is needed in Google Forms questionaire.',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.YellowWarn,
                      borderRadius: BorderRadius.circular(14)),
                  child: Column(children: [
                    Text(
                      'Your UID',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.uID,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => launchUrlString(''),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.MintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 0,
                      minimumSize: Size(335, 53),
                    ),
                    child: Text('Open Google Forms',
                        style:
                            TextStyle(fontSize: 18, color: AppColors.Cloud))),
              ],
            ),
          );
        },
      ),
    );
  }
}
