import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/screen_util.dart';
import 'package:money_tracker_app/utils/common_functions.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/view_models/submit_spending_view_model.dart';
import 'package:money_tracker_app/views/settings.dart';
import 'package:money_tracker_app/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:money_tracker_app/widgets/size_helpers.dart';
import 'package:stacked/stacked.dart';

class SubmitSpending extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  SubmitSpending(this.scaffoldKey);
  @override
  _SubmitSpendingState createState() => _SubmitSpendingState();
}

class _SubmitSpendingState extends State<SubmitSpending> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubmitSpendingViewModel>.reactive(
      onModelReady: (data) => data.initializeModel(),
      builder: (context, data, child) {
        return GestureDetector(
          onTap: () {
            context.unFocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Money Tracker'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenUtil.getInstance().height * .05,
                ),
                Container(
                  child: new TextField(
                    controller: data.amountController,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    style: TextStyle(fontSize: 8 * SizeConfig.textMultiplier),
                    decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                      hintText: data.currentValue,
                      hintStyle:
                          TextStyle(fontSize: 8 * SizeConfig.textMultiplier),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(
                  //     left: 3.5 * SizeConfig.widthMultiplier,
                  //     right: 3.5 * SizeConfig.widthMultiplier,
                  //     bottom:
                  //     SizeConfig.heightMultiplier * 17),
                  //height: 5.2 * SizeConfig.heightMultiplier,
                  child: Center(
                    child: data.errorMessage != null
                        ? Text(
                      data.errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 2 *
                            SizeConfig.textMultiplier,
                      ),
                      maxLines: null,
                      textAlign: TextAlign.center,
                    )
                        : Container(),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 3.5,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(SizeConfig.widthMultiplier * 3.5,
                      0, SizeConfig.widthMultiplier * 3.5, 0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: new Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: new TextField(
                    focusNode: data.descriptionFocus,
                    // textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                      hintText: '(Optional) Enter Description',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 9.5,
                ),
                !data.loadSetting
                    ?
                SizedBox(
                  width: double.infinity,
                  height: SizeConfig.heightMultiplier * 8,
                  child: FlatButton(
                    onPressed: () {
                      data.calculateAmount();
                    },
                    child: Text(
                      'Spend',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.5,
                      ),
                    ),
                    color: ColorUtils.primaryColor,
                  ),
                )
                :
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RaisedButton(onPressed: (){},
                        elevation: 5.0,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20),
                        //height: SizeConfig.heightMultiplier * 10,
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2.5,
                            ),
                          ),
                        color: ColorUtils.primaryColor,
                      ),
                    ),
                    SizedBox(width: SizeConfig.widthMultiplier * 0.2,),
                    Expanded(
                      child: RaisedButton(onPressed: (){},
                        elevation: 5.0,
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20),
                        child: Text(
                          'Spend',
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.5,
                          ),
                        ),
                        color: ColorUtils.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2.5,
                ),
                Expanded(
                  child: Container(
                    //alignment: Alignment.bottomCenter,
                    //width: displayWidth(context)*1,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: data.button("1")),
                              Expanded(child: data.button("2")),
                              Expanded(child: data.button("3")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: data.button("4")),
                              Expanded(child: data.button("5")),
                              Expanded(child: data.button("6")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: data.button("7")),
                              Expanded(child: data.button("8")),
                              Expanded(child: data.button("9")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 3,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: data.button("C")),
                              Expanded(child: data.button("0")),
                              Expanded(child: data.button("⌫")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<SubmitSpendingViewModel>(),
      disposeViewModel: false,
    );
  }
}
