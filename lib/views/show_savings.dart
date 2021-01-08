import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/views/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSavings extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  ShowSavings(this.scaffoldKey);

  @override
  _ShowSavingsState createState() => _ShowSavingsState();
}

class _ShowSavingsState extends State<ShowSavings> {
  SharedPreferences pref;


  String amount = '';
  String savedAmount = '';
  double positiveRemaining = 0;
  String showSaving = '';
  String initialSave = '';

  void showAmount()async{
    pref = await SharedPreferences.getInstance();
    amount =  pref.getString("dailyAverage");
    showSaving = pref.getString("dailyAverage");
    //initialSave = await pref.getString("initialSavedMoney");
    //savedAmount = await pref.getString("savedAmount");
    //savedAmount = await initialSave;
    //showSaving = await pref.getString("savedMoney");
    // setState(() {
    //
    // });
    // if (savedAmount!=null)
    //   {
    //     amount = (double.parse(savedAmount)).toString();
    //   }
    if(showSaving != null){
      amount = (double.parse(showSaving)).toString();
    }
    positiveRemaining = double.parse(amount);

    print("");
    setState(() {

    });
  }

  // void getRemaining()async{
  //   pref = await SharedPreferences.getInstance();
  //   positiveRemaining = await pref.getString("dailyAverage");
  //   int number = int.parse(positiveRemaining);
  //   if(number >= 0){
  //
  //   }
  // }

  @override
  void initState() {
    showAmount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Money Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()));
            },
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
            positiveRemaining >= 0
            ?
            Text(
              '\$'+amount,
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 5,
                color: Colors.green,
              ),
            )
                :
            Text(
              '\$'+amount,
              style: TextStyle(fontSize: SizeConfig.textMultiplier * 5,
                color: Colors.red,
              ),
            ),
                // Text(
                //   amount = await pref.getString("remaining");
                // ),
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
