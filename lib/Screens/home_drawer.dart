import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/database_services.dart/shared_prefs_data.dart';
import 'package:test_app/models/user.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, data, child) {
      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(""),
                accountEmail: Text(data.user.email ?? "")),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            )
          ],
        ),
      );
    });
  }
}
