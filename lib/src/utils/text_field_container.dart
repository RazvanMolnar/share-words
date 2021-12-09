import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: MyConstants.defaultScreenPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: MyConstants.defaultScreenPadding),
      width: size.width,
      decoration: BoxDecoration(
        color: MyConstants.mainPrimaryInputBgColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: MyConstants.thirdColor),
      ),
      child: child,
    );
  }
}
