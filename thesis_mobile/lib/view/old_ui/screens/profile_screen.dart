import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/old_ui/popups/order_contact.dart';
import 'package:thesis_mobile/view/old_ui/screens/orders_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/stage_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] ProfileScreen');

    return Scaffold(
        appBar: AppBar(title: Text('Account')),
        body: ListView(padding: EdgeInsets.all(20), children: [
          StageCard(),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            onTap: () => customPagePush(context, OrdersScreen()),
            title: Text('Orders'),
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
                  borderRadius: BorderRadius.circular(14.0),
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
        ]));
  }
}
