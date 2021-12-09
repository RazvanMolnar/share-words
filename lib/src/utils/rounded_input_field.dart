import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.errorText,
    this.icon = Icons.search_outlined,
    required this.onChanged,
    required this.keyboardType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: const TextStyle(
          color: MyConstants.mainPrimaryTextColor,
        ),
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        cursorColor: MyConstants.mainPrimaryTextColor,
        decoration: InputDecoration(
          errorText: errorText,
          // suffixIcon: Icon(
          //   icon,
          //   color: MyConstants.mainPrimaryTextColor,
          // ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: MyConstants.secondInputColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
