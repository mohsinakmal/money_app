// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************



import 'package:get_it/get_it.dart';
import 'package:money_tracker_app/view_models/my_base_view_model.dart';
import 'package:money_tracker_app/view_models/nav_view_model.dart';
import 'package:money_tracker_app/view_models/submit_spending_view_model.dart';


Future<void> $initGetIt(GetIt g, {String environment}) async{
  g.registerLazySingleton<NavViewModel>(() => NavViewModel());
  g.registerLazySingleton<SubmitSpendingViewModel>(() => SubmitSpendingViewModel());
  g.registerLazySingleton<MyBaseViewModel>(() => MyBaseViewModel());
  // PrefrencesViewModel prefrencesViewModel = PrefrencesViewModel();
  // await prefrencesViewModel.getUserData();
  // g.registerLazySingleton<PrefrencesViewModel>(() => prefrencesViewModel);
}
