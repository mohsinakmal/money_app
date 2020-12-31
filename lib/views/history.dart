import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/utils/constants.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/view_models/history_view_model.dart';
import 'package:money_tracker_app/views/settings.dart';
import 'package:stacked/stacked.dart';

class History extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  History(this.scaffoldKey);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, data, child) {
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
                  child: Text(
                    'Today\'s Spending',
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    '\$12.59',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 2,
                                  ),
                                  Text(
                                    '(10.02 PM)',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 2),
                                  ),
                                  Spacer(),
                                  PopupMenuButton<String>(
                                    onSelected: data.choiceAction,
                                    itemBuilder: (BuildContext context) {
                                      return Constants.choices
                                          .map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                    icon: Icon(Icons.arrow_drop_down_circle),
                                  ),
                                ],
                              ),
                              subtitle: Text('Dinner-pizza'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<HistoryViewModel>(),
      disposeViewModel: false,
    );
  }
}
