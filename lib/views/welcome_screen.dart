import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/view_models/history_view_model.dart';
import 'package:money_tracker_app/views/enter_amount.dart';
import 'package:money_tracker_app/views/money_tracker_mainView.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    locator<HistoryViewModel>().initializeModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/my_icon.png',
              width: SizeConfig.imageSizeMultiplier * 30,
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
              child: Text(
                'Welcome to Money Tracker!',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 3,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. Set your Daily Limits',
                  style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.3),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.4,
                  ),
                  Text('2. Keep recording your spending',
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.3),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 0.4,
                  ),
                  Text('3. See how much you have saved',
                    style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.3),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 1,
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => EnterAmount()));
              },
              child: Container(
                child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
                    )),
                height: SizeConfig.heightMultiplier * 8,
                width: double.infinity,
                margin: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                decoration: BoxDecoration(
                  color: ColorUtils.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
