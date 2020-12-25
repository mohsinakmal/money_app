
import 'package:stacked/stacked.dart';

class NavViewModel extends BaseViewModel{
  int currentIndex = 0;
  void updateIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}