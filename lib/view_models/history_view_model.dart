import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';
import 'package:hive/hive.dart';

class HistoryViewModel extends MyBaseViewModel {
  var moneyBox;
  List<String> lItems = [];
  Map historyMap = Map();
  List historyDataList = [];
  List historyDatesList = [];
  String descriptionDetails = '';
  bool isDescriptionTrue = false;
  void initializeModel()async{

    moneyBox = await Hive.openBox('money');
    getHistory();
  }
  void getHistory(){
    historyMap = moneyBox.get('history')??{};
  }

  // void description(String descriptionValue){
  //   String descriptionDetail = descriptionValue;
  //   moneyBox.put('description', descriptionDetail);
  //   notifyListeners();
  // }

  void saveSpent(String spentHistory, String descriptionValue) {
    historyMap[Timestamp.now().toDate().toString()] = {'type' : 'spent' , 'value' : spentHistory, 'description' : descriptionValue, 'isTrueDescription' : isDescriptionTrue == true };
    moneyBox.put('history', historyMap);
    notifyListeners();
  }

  void addMoreAmount(String savedHistory, String descriptionValue) {
    historyMap[Timestamp.now().toDate().toString()] = {'type' : 'addMore' , 'value' : savedHistory, 'description' : descriptionValue, 'isTrueDescription' : isDescriptionTrue == false };
    moneyBox.put('history', historyMap);
    notifyListeners();
  }

  void sortHistory() {
  setBusy(true);
  isDescriptionTrue = false;
  historyDataList.clear();
  historyDatesList = historyMap.keys.toList();
  historyDatesList.sort((a,b) => b.compareTo(a));
  historyDatesList.forEach((historyDate) {
    historyDataList.add(historyMap[historyDate]);
  });
  setBusy(false);
  }
}
