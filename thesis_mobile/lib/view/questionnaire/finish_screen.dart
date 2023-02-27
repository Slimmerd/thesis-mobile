import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/api/external_api.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/screens/main_screen.dart';
import 'package:thesis_mobile/view/old_ui/screens/navbar_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  bool isLoading = false;

  Future<void> uploadData(Map<String, dynamic> data) async {
    setState(() => isLoading = true);

    final TaskManagerBloc taskMng = BlocProvider.of<TaskManagerBloc>(context);
    int apiResponse = await ExternalApiService().postLogData(data);

    if (apiResponse == 201) {
      taskMng.setUploadedTask();
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finish stage'),
      ),
      body: BlocBuilder<TaskManagerBloc, TaskManagerState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'You have completed practical part of research. For now you will have to upload the data and complete questionaire using Google Forms. Unique identifier below is needed in Google Forms questionaire. The data will be uploaded automatically after you press the button "Upload"',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.yellowWarn,
                      borderRadius: BorderRadius.circular(14)),
                  child: Column(children: [
                    Text(
                      'Your UID',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      state.uID,
                      style: Theme.of(context).textTheme.headline4,
                    )
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (!isLoading && !state.isUploaded) {
                        await uploadData(state.toJson());
                      }

                      if (!isLoading && state.isUploaded) {
                        launchUrlString('https://forms.gle/gA33cJfrRZc7r6CN7');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mintGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 0,
                      minimumSize: const Size(335, 53),
                    ),
                    child: Text(
                        state.isUploaded ? 'Open Google Forms' : 'Upload',
                        style: const TextStyle(
                            fontSize: 18, color: AppColors.cloud))),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () =>
                        customPagePushRemove(context, const NavbarScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dorian,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 0,
                      minimumSize: const Size(335, 53),
                    ),
                    child: const Text('Open App 1',
                        style: TextStyle(
                            fontSize: 18, color: AppColors.graphite))),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () =>
                        customPagePushRemove(context, const MainScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dorian,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 0,
                      minimumSize: const Size(335, 53),
                    ),
                    child: const Text('Open App 2',
                        style: TextStyle(
                            fontSize: 18, color: AppColors.graphite))),
              ],
            ),
          );
        },
      ),
    );
  }
}
