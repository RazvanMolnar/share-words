import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimpleBottomNavigationBar extends StatelessWidget {
  const SimpleBottomNavigationBar({
    Key? key,
    required this.selectedTab,
    required this.onTap,
  }) : super(key: key);

  final int selectedTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedTab,
      type: BottomNavigationBarType.fixed,
      backgroundColor: MyConstants.mainPrimaryInputBgColor,
      iconSize: 24,
      items: List.generate(
        navIconSrc.length,
        (index) => BottomNavigationBarItem(
          icon: SvgPicture.asset(
            navIconSrc[index],
            // height: 50,
            color: MyConstants.redColor,
            // color: index == selectedTab
            //     ? MyConstants.redBorderColor
            //     : Colors.white,
          ),
          label: "",
        ),
      ),
    );
  }
}

List<String> navIconSrc = [
  "assets/images/baby-food.svg",
  "assets/images/Tyre.svg",
];
