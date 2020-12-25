
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_tracker_app/utils/color_utils.dart';
import 'package:money_tracker_app/utils/sizeconfig.dart';
import 'package:money_tracker_app/view_models/nav_view_model.dart';
import 'package:stacked/stacked.dart';

class NavBar extends ViewModelWidget<NavViewModel>{
  List navDataList = [
    {"icon" : Icons.attach_money, "name" : "Spend"},
    {"icon" : Icons.add_chart, "name" : "Display"},
    {"icon" : Icons.history, "name" : "History"},
  ];
  List<Widget> getNavItems(NavViewModel model){
    return List.generate(3, (index) => Expanded(
      flex: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          if(index != model.currentIndex){
            model.updateIndex(index);
          }
        },
        child: Container(
          child: Column(
            children: [
              Image.asset(navDataList[index]['icon'],width: 4.3*SizeConfig.imageSizeMultiplier,height: 4.3*SizeConfig.imageSizeMultiplier,
                color: model.currentIndex==index? ColorUtils.primaryColor : Colors.grey,),
              SizedBox(height: 1.5*SizeConfig.imageSizeMultiplier,),
              Text(navDataList[index]['name'],style: TextStyle(
                  color: model.currentIndex==index? ColorUtils.primaryColor : Colors.grey ,fontSize: 1.6*SizeConfig.textMultiplier,
              ),)
            ],
          ),
        ) ,
      ),
    )
    );
  }
  @override
  Widget build(BuildContext context, NavViewModel model) {
    return  Container(
      height: 8*SizeConfig.heightMultiplier,
      width: double.infinity,
      color: ColorUtils.primaryColor,
      child: Row(
          children: getNavItems(model)
      ),
    );
  }
  
}