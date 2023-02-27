import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:thesis_mobile/core/bloc/task_manager/task_manager_bloc.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/old_ui/popups/order_contact.dart';
import 'package:thesis_mobile/view/old_ui/screens/orders_screen.dart';
import 'package:thesis_mobile/view/old_ui/widgets/stage_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskContext = BlocProvider.of<TaskManagerBloc>(context);
    taskContext.addLogTask('[OLDUI][OPENED] ProfileScreen');

    return Scaffold(
        appBar: AppBar(title: const Text('Account')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          const StageCard(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            onTap: () => customPagePush(context, const OrdersScreen()),
            title: Text(
              'Orders',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const OrderContact(),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.dorian,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                elevation: 0,
                minimumSize: const Size(335, 53),
              ),
              child: const Text('Contact us',
                  style: TextStyle(fontSize: 18, color: AppColors.graphite))),
          const SizedBox(
            height: 20,
          ),
          //todo
          TextButton(
              onPressed: () => launchUrlString(''),
              child: const Text('Rules and agreements')),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
                  'Version ${_packageInfo.version} (${_packageInfo.buildNumber})')),
        ]));
  }
}
