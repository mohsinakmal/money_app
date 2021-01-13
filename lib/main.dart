import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/screen_util.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/views/money_tracker_mainView.dart';
import 'package:money_tracker_app/views/submit_spending.dart';
import 'package:money_tracker_app/views/welcome_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configure();
  SharedPreferences pref = await SharedPreferences.getInstance();
  int initialAmount = int.parse(await pref.get("initialAmount") ?? "0");
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  runApp(
     App(initialAmount),
  );
}

class App extends StatefulWidget {
  int initialAmount;

  App(this.initialAmount);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      home: MyApp(widget.initialAmount),
      theme: ThemeData(
        primaryColor: ColorUtils.primaryColor,
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  int amount;

  MyApp(this.amount);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(
        width: MediaQuery.of(context).size.width.round(),
        height: MediaQuery.of(context).size.height.round(),
        allowFontScaling: true);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            if (widget.amount>0)
              return MoneyTrackerMainView();
            else
              return WelcomeScreen();
          },
        );
      },
    );
  }
}
