
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/utils/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'money_tracker_mainView.dart';

class EnterAmount extends StatefulWidget {
  @override
  _EnterAmountState createState() => _EnterAmountState();
}

class _EnterAmountState extends State<EnterAmount> {
  String errorMessage;
  SharedPreferences pref;
  final enteredAmountController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var amountBox;

  void showErrorMessage(String error)async{
    errorMessage = error;
    setState(() {

    });
    await Future.delayed(Duration(seconds: 3));
    errorMessage = null;
    setState(() {

    });
  }
  void amountEntered()async{
    if(enteredAmountController.text.isNotEmpty){
      pref = await SharedPreferences.getInstance();
      await pref.setString('dailyAverage', enteredAmountController.text);
      await pref.setString('initialAmount', enteredAmountController.text);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MoneyTrackerMainView()));
    }
    else{
      showErrorMessage('Please Enter some number');
    }
  }

  Future<dynamic> createUsers()async{
    try{
      await firestore.collection("Users").doc().id;
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.unFocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.attach_money,
                color: ColorUtils.primaryColor,
                size: SizeConfig.imageSizeMultiplier * 30,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: SizeConfig.heightMultiplier * 3),
                child: Text(
                  'How much would you like to spend daily on average?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3.3,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              Container(
                margin: EdgeInsets.all(SizeConfig.widthMultiplier * 3),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(0, 1),
                    )
                  ],
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: new TextField(
                  controller: enteredAmountController,
                  textAlign: TextAlign.center,
                  //readOnly: true,
                  style: TextStyle(fontSize: 4 * SizeConfig.textMultiplier),
                  decoration: new InputDecoration(
                    contentPadding:
                    EdgeInsets.only(left: SizeConfig.widthMultiplier * 2),
                    hintText: 'Enter Daily Limit',
                    hintStyle:
                    TextStyle(fontSize: 3 * SizeConfig.textMultiplier),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 1,
              ),
              GestureDetector(
                onTap: ()async{
                  amountEntered();
                  createUsers();
                },
                child: Container(
                  child: Center(
                      child: Text(
                        'Start',
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      left: 3.5 * SizeConfig.widthMultiplier,
                      right: 3.5 * SizeConfig.widthMultiplier,
                      bottom:
                      SizeConfig.heightMultiplier * 17),
                  height: 5.2 * SizeConfig.heightMultiplier,
                  child: Center(
                    child: errorMessage != null
                        ? Text(
                      errorMessage,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
