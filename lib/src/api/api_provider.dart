import 'dart:async';
import 'dart:io';

import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/models/word_model.dart';
import 'package:filip/src/api/repository.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _root = Utils.getRootUrl();

class ApiProvider implements Source {
  Client client = Client();

  Future<CategoryModel?> addCategory(String name) async {
    try {
      final body = {"name": name};
      final response = await http
          .post(
            Uri.parse('$_root/categories/create'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Accept-Language": "ro"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["category"];
        final CategoryModel category = CategoryModel.fromMap(parsedJson);
        return category;
      }

      return null;
    } on TimeoutException catch (_) {
      throw Exception("Server timeout");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }

  Future<dynamic> addCategoryWord(String name, String categoryId) async {
    try {
      final body = {"name": name, "category": categoryId};
      final response = await http
          .post(
            Uri.parse('$_root/words/create'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Accept-Language": "ro"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["word"];
        return WordModel.fromMap(parsedJson);
      }

      final parsedJsonMessage = json.decode(response.body)["message"];
      return parsedJsonMessage;
    } on TimeoutException catch (_) {
      print("time out");
      throw Exception("nu e pornit serverul");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }

  @override
  Future<WordModel?> updateCategoryWord(
      String name, String slug, String categoryId) async {
    try {
      final body = {"name": name, "category": categoryId};
      final response = await http
          .put(
            Uri.parse('$_root/words/$slug'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Accept-Language": "ro"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["word"];
        return WordModel.fromMap(parsedJson);
      }

      return null;
    } on TimeoutException catch (_) {
      print("time out");
      throw Exception("nu e pornit serverul");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }

  Future<CategoryModel?> updateCategory(String name, String slug) async {
    try {
      final body = {"name": name};
      final response = await http
          .put(
            Uri.parse('$_root/categories/$slug'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Accept-Language": "ro"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["category"];
        return CategoryModel.fromMap(parsedJson);
      }

      return null;
    } on TimeoutException catch (_) {
      print("time out");
      throw Exception("nu e pornit serverul");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }

  Future<String?> deleteCategoryWord(String slug) async {
    try {
      final response = await http.delete(
        Uri.parse('$_root/words/$slug'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept-Language": "ro"
        },
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["message"];
        return parsedJson;
      }
      return null;
    } on TimeoutException catch (_) {
      print("time out");
      throw Exception("nu e pornit serverul");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }

  Future<String?> deleteCategory(String slug) async {
    try {
      final response = await http.delete(
        Uri.parse('$_root/categories/$slug'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept-Language": "ro"
        },
      ).timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        final parsedJson = json.decode(response.body)["message"];
        return parsedJson;
      }
      return null;
    } on TimeoutException catch (_) {
      print("time out");
      throw Exception("nu e pornit serverul");
    } on SocketException catch (_) {
      // print('socket exc');
    }
  }
}
