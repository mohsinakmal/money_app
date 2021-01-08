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
  void initializeModel()async{
    moneyBox = await Hive.openBox('money');
    getHistory();
  }
  void getHistory(){
    historyMap = moneyBox.get('history')??{};
  }

  void saveSpent(String spentHistory) {
    historyMap[Timestamp.now().toDate().toString()] = {'type' : 'spent' , 'value' : spentHistory};
    moneyBox.put('history', historyMap);
    notifyListeners();
  }

  void addMoreAmount(String savedHistory) {
    historyMap[Timestamp.now().toDate().toString()] = {'type' : 'addMore' , 'value' : savedHistory};
    moneyBox.put('history', historyMap);
    notifyListeners();
  }

  void sortHistory() {
  setBusy(true);
  historyDataList.clear();
  historyDatesList = historyMap.keys.toList();
  historyDatesList.sort((a,b) => b.compareTo(a));
  historyDatesList.forEach((historyDate) {
    historyDataList.add(historyMap[historyDate]);
  });
  setBusy(false);
  }
}
