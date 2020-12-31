import 'package:flutter/material.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';
import 'package:money_tracker_app/views/money_tracker_mainView.dart';
import 'package:money_tracker_app/views/submit_spending.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends MyBaseViewModel {
  bool saveSwitched = false;
  bool historySwitched = false;
  String dailyAmount = '';
  SharedPreferences pref;
  //bool saveToggle = false;

  void initializeModel(BuildContext context)async{
    pref = await SharedPreferences.getInstance();
    dailyAmount = await pref.getString('dailyAverage');
    saveSwitched = await pref.getBool('toggleState');
    //await  pref.setBool("toggleState", saveSwitched);
    notifyListeners();
  }

  void choiceAction(String choice) {
    print('Working!');
  }

  saveButton(bool value) {
    saveSwitched = value;
    //pref.setBool("save", value);
    notifyListeners();
  }

  historyButton(bool value) {
    historySwitched = value;
    notifyListeners();
  }
  void getDailyAmount()async{
    pref = await SharedPreferences.getInstance();
    dailyAmount = await pref.getString('dailyAverage');
    notifyListeners();
  }
  void saveSettings(BuildContext context)async{
    await  pref.setBool("toggleState", saveSwitched);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoneyTrackerMainView()));
  }

}
