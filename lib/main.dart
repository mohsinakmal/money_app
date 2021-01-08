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

import 'app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configure();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Tracker',
      home: MyApp(),
      theme: ThemeData(
        primaryColor: ColorUtils.primaryColor,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
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
            return WelcomeScreen();
          },
        );
      },
    );
  }
}
