import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/bloc/data_bloc.dart';
import 'package:test_app/Screens/home_screen.dart';
import 'package:test_app/Screens/login_screen.dart';
import 'package:test_app/database_services.dart/shared_prefs_data.dart';
import 'package:test_app/models/user.dart';

User user;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  user = await UserProvider().fetchUser();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
        bloc: DataBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: user.loggedIn != null
              ? HomeScreen(
                  user: user,
                )
              : LoginScreen(
                  key: key,
                ),
        ));
  }
}
