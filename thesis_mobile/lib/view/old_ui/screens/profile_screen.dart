import 'package:flutter/material.dart';
import 'package:thesis_mobile/utils/colors.dart';
import 'package:thesis_mobile/utils/custom_page_push.dart';
import 'package:thesis_mobile/view/old_ui/screens/orders_screen.dart';
import 'package:thesis_mobile/view/old_ui/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('Account')),
        body: ListView(padding: EdgeInsets.all(20), children: [
          Text('Daniil'),
          Text('+7 999 000 00 00'),
          Text('email_email@email.com'),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            onTap: () => customPagePush(context, OrdersScreen()),
            title: Text('Orders'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            onTap: () => customPagePush(context, SettingsScreen()),
            title: Text('Settings'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {},
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
          TextButton(onPressed: () {}, child: Text('FAQ')),
          TextButton(onPressed: () {}, child: Text('Rules and agreements')),
          TextButton(onPressed: () {}, child: Text('Become courier')),
        ]));
  }
}