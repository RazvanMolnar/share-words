import 'package:filip/keys.dart';
import 'package:filip/src/exceptions/authentication_exception.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';

class Utils {
  static const isDEV = 1;
  static String getRootUrl() {
    if (Utils.isDEV == 1) {
      return localServer;
    }
    return productionServer;
  }

  static void showMessage(BuildContext context, String message,
      {Color color = MyConstants.redBorderColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      backgroundColor: MyConstants.greenColor,
    ));
  }

  static void showErrorMessage(BuildContext context, String message,
      {Color color = MyConstants.redBorderColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
    ));
  }

  static void showApiErrorMessages(
      BuildContext context, List<ApiError> apiErrors,
      {Color color = MyConstants.redBorderColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Padding(
        padding: const EdgeInsets.all(MyConstants.screen10Padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:
              apiErrors.map((apiError) => Text(apiError.toString())).toList(),
        ),
      ),
      backgroundColor: MyConstants.redColor,
    ));
  }
}
