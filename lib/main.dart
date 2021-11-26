import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/bloc/data_bloc.dart';
import 'package:test_app/Screens/home_screen.dart';
import 'package:test_app/Screens/login_screen.dart';
import 'package:test_app/database_services.dart/shared_prefs_data.dart';

bool loggedIn;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  loggedIn = prefs.getBool('loggedIn');
  await runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider())
  ], child: const MyApp()));
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
          home: loggedIn != null
              ? HomeScreen()
              : LoginScreen(
                  key: key,
                ),
        ));
  }
}
