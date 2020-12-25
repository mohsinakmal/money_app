
import 'package:flutter/cupertino.dart';

extension contextExtension on BuildContext{
  void unFocus(){
    FocusScope.of(this).requestFocus(FocusNode());
  }
}