import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ny_times_api_test_flutter/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NY Times Articles',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      // builder: DevicePreview.appBuilder,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
