import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/new_ui/popups/order_contact.dart';
import 'package:thesis_mobile/view/new_ui/screens/achievements_screen.dart';
import 'package:thesis_mobile/view/new_ui/screens/orders_screen.dart';
import 'package:thesis_mobile/view/new_ui/screens/statistics_screen.dart';
import 'package:thesis_mobile/view/new_ui/widgets/stage_card.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[NEWUI][OPENED] MenuScreen');

    return Scaffold(
      appBar: AppBar(),
      body: ListView(padding: EdgeInsets.all(20), children: [
        StageCard(),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          onTap: () => customPagePush(context, OrdersScreen()),
          title: Text('Orders'),
        ),
        ListTile(
          leading: Icon(Icons.forest),
          onTap: () => customPagePush(context, StatisticsScreen()),
          title: Text('Statistics'),
        ),
        ListTile(
          leading: Icon(Icons.star),
          onTap: () => customPagePush(context, AchievementsScreen()),
          title: Text('Achievements'),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => OrderContact(),
                ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.Dorian,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(34.0),
              ),
              elevation: 0,
              minimumSize: Size(335, 53),
            ),
            child: Text('Contact us',
                style: TextStyle(fontSize: 18, color: AppColors.Graphite))),
        SizedBox(
          height: 20,
        ),
        TextButton(onPressed: () {}, child: Text('Rules and agreements')),
      ]),
    );
  }
}
