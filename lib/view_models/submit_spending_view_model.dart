import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';

class SubmitSpendingViewModel extends MyBaseViewModel {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  FocusNode descriptionFocus = new FocusNode();
  bool isDescriptionInFocus = false;
  String currentValue = "\$0.00";

  void initializeModel() async {
    descriptionController.clear();
    isDescriptionInFocus = false;
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

// Widget deleteButton(Icon icon){
//   return IconButton(
//     icon: icon,
//     onPressed: (){},
//   );
// }
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
}
