import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/constants.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';
import 'package:money_tracker_app/views/money_tracker_mainView.dart';
import 'package:money_tracker_app/views/submit_spending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends MyBaseViewModel {
  bool saveSwitched = false;
  bool historySwitched = false;
  String dailyAmount = '';
  SharedPreferences pref;
  bool savedToggle = false;
  String currencies = Constants.dollars;

  void initializeModel(BuildContext context)async{
    pref = await SharedPreferences.getInstance();
    dailyAmount = pref.getString('initialAmount');
    saveSwitched = pref.getBool('toggleState') ?? false;
    savedToggle = pref.getBool("save") ?? false;
    notifyListeners();
  }

  void choiceAction(String value) {
    currencies = value;
    notifyListeners();
  }

  saveButton(bool value) {
    saveSwitched = value;
    pref.setBool("save", saveSwitched);
    notifyListeners();
  }

  historyButton(bool value) {
    historySwitched = value;
    notifyListeners();
  }
  void getDailyAmount()async{
    pref = await SharedPreferences.getInstance();
    dailyAmount = pref.getString('dailyAverage');
    notifyListeners();
  }
  void saveSettings(BuildContext context)async{
    await pref.setBool("toggleState", saveSwitched);
    await pref.setString("currency", currencies);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoneyTrackerMainView()));
    notifyListeners();
  }

  void onCancelPress(BuildContext context){
    Navigator.pop(context);
  }

  void onContinuePress(BuildContext context, String value){
    currencies = value;
    Navigator.pop(context);
    notifyListeners();
  }

  showAlertDialog(BuildContext context,String value) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
       onCancelPress(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        onContinuePress(context, value);
        //notifyListeners();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text("Changing the currency will clear all data and restart. Please backup your data if you need to."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
