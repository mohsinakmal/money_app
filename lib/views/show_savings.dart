import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';

class ShowSavings extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  ShowSavings(this.scaffoldKey);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Money Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remaining Today',
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
            ),
            Text(
              "\$0.00",
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 5),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Text(
              'Monthly Saving',
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 3),
            ),
            Text(
              "\$0.00",
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 5),
            ),
          ],
        ),
      ),
    );
  }
}
