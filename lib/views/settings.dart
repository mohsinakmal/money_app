import 'package:flutter/material.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/constants.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/view_models/settings_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      onModelReady: (data) => data.initializeModel(context),
      builder: (context, data, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Money Tracker'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'System Values',
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 0,
                        //offset: Offset(0, 1),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Current daily limit',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                          Container(
                            child: Text(
                               data.dailyAmount,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            right: SizeConfig.widthMultiplier * 3),
                        child: Text(
                          'Change Daily Limit',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.5),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Currency',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                          Row(
                            children: [
                              Text(data.currencies,
                                style: TextStyle(fontSize: 17.0),
                              ),
                              Container(
                                child: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    data.showAlertDialog(context,value);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return Constants.currencies
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                  icon: Icon(Icons.arrow_drop_down_circle),
                                ),
                                margin:
                                    EdgeInsets.all(SizeConfig.widthMultiplier * 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'System UI',
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 0,
                        //offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Show Save Button',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                          Container(
                            child: Switch(
                              activeColor: ColorUtils.primaryColor,
                              value: data.saveSwitched,
                              onChanged: (value) {
                                data.saveButton(value);
                              },
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Show Entire History',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                          Container(
                            child: Switch(
                              activeColor: ColorUtils.primaryColor,
                              value: data.historySwitched,
                              onChanged: (value) {
                                data.historyButton(value);
                              },
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Manage Subscriptions',
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 0,
                        //offset: Offset(0, 3),
                      )
                    ],
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          child: Text(
                            'Add New Subscription',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                          child: Text(
                            'View Subscriptions',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 2.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    data.saveSettings(context);
                  },
                  child: Container(
                    child: Center(
                        child: Text(
                      'Save Setting',
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
      },
      viewModelBuilder: () => locator<SettingsViewModel>(),
      disposeViewModel: false,
    );
  }
}


