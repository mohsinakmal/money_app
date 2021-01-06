
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/view_models/nav_view_model.dart';
import 'package:stacked/stacked.dart';

class MyBaseViewModel extends BaseViewModel{
  var navService = locator<NavViewModel>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}