import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/models/week_days_model.dart';
import 'package:filip/src/models/word_model.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

final String _root = Utils.getRootUrl();
Client client = Client();

Future<List<CategoryModel>?> fetchCategories() async {
  try {
    final response = await http.get(
      Uri.parse('$_root/categories'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept-Language": "ro"
      },
    ).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body)["categories"];
      List<CategoryModel> listaCuvinte =
          (parsedJson as List).map((i) => CategoryModel.fromMap(i)).toList();
      return listaCuvinte.cast<CategoryModel>();
    }

    return null;
  } on TimeoutException catch (_) {
    print("time out");
    throw Exception("nu e pornit serverul");
  } on SocketException catch (_) {
    // print('socket exc');
  }
}

Future<int?> fetchTotal() async {
  try {
    final response = await http.get(
      Uri.parse('$_root/words/total-cuvinte'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept-Language": "ro"
      },
    ).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      return json.decode(response.body)["total"];
    }

    return 0;
  } on TimeoutException catch (_) {
    print("time out");
    throw Exception("nu e pornit serverul");
  } on SocketException catch (_) {
    // print('socket exc');
  }
}

Future<List<WordModel>?> fetchCategoryWords(String slug) async {
  try {
    print('categories');

    final response = await http.get(
      Uri.parse('$_root/categories/list/$slug'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept-Language": "ro"
      },
    ).timeout(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body)["words"];
      List<WordModel> listaCuvinte =
          (parsedJson as List).map((i) => WordModel.fromMap(i)).toList();
      return listaCuvinte.cast<WordModel>();
    }

    return null;
  } on TimeoutException catch (_) {
    print("time out");
    throw Exception("nu e pornit serverul");
  } on SocketException catch (_) {
    // print('socket exc');
  }
}

Future<List<WeekDaysModel>?> fetchWeekDays(WeeksModel week) async {
  try {
    final response = await http.get(
      Uri.parse('$_root/weekdays/${week.weekNr}'),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept-Language": "ro"
      },
    );

    if (response.statusCode == 200) {
      //TODO
    }

    return weekMenu;
  } on TimeoutException catch (_) {
    print("time out");
    throw Exception("nu e pornit serverul");
  } on SocketException catch (_) {
    // print('socket exc');
  }

  // if (response.statusCode == 200) {
  //   final parsedJson = json.decode(response.body)["words"];
  //   List<WeekDaysModel> listaCuvinte =
  //       (parsedJson as List).map((i) => WeekDaysModel.fromMap(i)).toList();
  //   return listaCuvinte.cast<WeekDaysModel>();
  // }

  // return null;
}
