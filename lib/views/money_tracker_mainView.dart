import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/app/locator.dart';
import 'package:money_tracker_app/view_models/nav_view_model.dart';
import 'package:money_tracker_app/views/history.dart';
import 'package:money_tracker_app/views/show_savings.dart';
import 'package:money_tracker_app/views/submit_spending.dart';
import 'package:money_tracker_app/widgets/nav_bar.dart';
import 'package:stacked/stacked.dart';

class MoneyTrackerMainView extends StatefulWidget {
  @override
  _MoneyTrackerMainViewState createState() => _MoneyTrackerMainViewState();
}

class _MoneyTrackerMainViewState extends State<MoneyTrackerMainView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget getBodyViews(int index) {
    switch (index) {
      case 0:
        return SubmitSpending(_scaffoldKey);
      case 1:
        return ShowSavings(_scaffoldKey);
      case 2:
        return History(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: NavBar(),
          body: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: getBodyViews(model.currentIndex),
          ),
        );
      },
      viewModelBuilder: () => locator<NavViewModel>(),
      disposeViewModel: false,
    );
  }
}
