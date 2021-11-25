import 'package:flutter/material.dart';
import 'package:test_app/database_services.dart/shared_prefs_data.dart';
import 'package:test_app/models/user.dart';

class HomeDrawer extends StatefulWidget {
  final User user;
  const HomeDrawer({Key key, this.user}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text(widget.user.email)),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
