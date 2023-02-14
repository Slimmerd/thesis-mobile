import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/make_dismissible.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderContact extends StatelessWidget {
  const OrderContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] OrderContactPopup');

    return makeDismissible(
        context: context,
        child: DraggableScrollableSheet(
          maxChildSize: 0.30,
          initialChildSize: 0.30,
          minChildSize: 0.30,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.Cloud,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              child: ListView(
                physics: ClampingScrollPhysics(),
                controller: scrollController,
                children: [
                  Text(
                    'Contact us',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () => launchUrlString(
                          'mailto:client@client.ru?subject=Problem'),
                      child: Text(
                        'client@client.ru',
                        style: Theme.of(context).textTheme.headline5,
                      )),
                ],
              ),
            );
          },
        ));
  }
}
