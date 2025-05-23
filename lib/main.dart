import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'providers/project_task_provider.dart';
import 'screens/add_time_entry_screen.dart';
import 'screens/project_task_management_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(MyApp(localStorage: localStorage));
}

class MyApp extends StatelessWidget {
  final LocalStorage localStorage;

  const MyApp({Key? key, required this.localStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeEntryProvider()),
      ],
      child: MaterialApp(
        title: 'Time Tracker',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(), // Main entry point, HomeScreen
          '/add_time_entry': (context) =>
              AddTimeEntryScreen(), // Route for adding time entry
          '/project_task_management': (context) =>
              ProjectTaskManagementScreen(), // Route for managing tags
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}
