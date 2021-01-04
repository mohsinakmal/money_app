import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitSpendingViewModel extends MyBaseViewModel {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  FocusNode descriptionFocus = new FocusNode();
  bool isDescriptionInFocus = false;
  String currentValue = "\$0.00";
  String errorMessage;
  SharedPreferences pref;
  bool loadSetting = false;
  bool savedToggle = false;

  void initializeModel() async {
    pref = await SharedPreferences.getInstance();
    loadSetting = await pref.getBool("toggleState");
    savedToggle = await pref.getBool("save");
    descriptionController.clear();
    isDescriptionInFocus = false;
    notifyListeners();
  }

  void _onDescriptionFocus() {
    if (descriptionFocus.hasFocus) {
      isDescriptionInFocus = true;
    } else {
      isDescriptionInFocus = false;
    }
    notifyListeners();
  }

  void setFocusListeners() async {
    descriptionFocus.addListener(_onDescriptionFocus);
  }

  Widget button(String number) {
    return InkWell(
        //height: 100.0,
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
        ),
        //textColor: Colors.black,
        // color: Colors.grey[100],
        onTap: () => buttonPressed(number));
  }

  buttonPressed(String number) {
    if (number == "C") {
    } else if (number == "⌫") {
      if (amountController.text.length == 3) {
        var oldValues = amountController.text.characters.toList();
        amountController.clear();
        for (int i = 0; i < oldValues.length; i++) {
          if (i == 0 || i == 1) {
          } else {
            amountController.text = "." + amountController.text + oldValues[i];
          }
        }
      } else if (amountController.text.length == 2) {
        amountController.clear();
      } else {
        amountController.text =
            amountController.text.substring(1, amountController.text.length);
      }
    } else {
      if (amountController.text.length == 3) {
        amountController.text = number + amountController.text;
      } else if (amountController.text.length < 3) {
        if (amountController.text.length == 0) {
          amountController.text = '.' + number;
        } else if (amountController.text.length == 2) {
          amountController.text = amountController.text.substring(1, 2);
          amountController.text = "." + number + amountController.text;
        }
      } else {
        amountController.text = number + amountController.text;
      }
    }
  }

  void showErrorMessage(String error)async{
    errorMessage = error;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    errorMessage = null;
    notifyListeners();
  }

  // void initialAmount()async{
  //   if(amountController.text.isEmpty){
  //     String dailyAverage = await pref.get("dailyAverage");
  //     String remaining = dailyAverage;
  //     await pref.setString('initial', remaining);
  //   }
  //   else{
  //     calculateAmount();
  //   }
  // }

  void calculateAmount()async{
    if(amountController.text.isNotEmpty){
      String dailyAverage = await pref.get("dailyAverage");
      dailyAverage = (double.parse(dailyAverage) - double.parse(amountController.text)).toStringAsFixed(2);
        await pref.setString('dailyAverage', dailyAverage);
        amountController.clear();

    }
    else{
      showErrorMessage('Enter the Amount');
    }
  }
}
