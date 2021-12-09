// import 'dart:convert';
// import 'package:filip/src/exceptions/authentication_exception.dart';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/models/word_model.dart';
import 'dart:async';
// import 'dart:io';

import 'package:filip/src/api/api_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    // newsDbProvider, // instance
    ApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    // newsDbProvider,
  ];

  Future<CategoryModel?> addCategory(String name) async {
    final apiSource = ApiProvider();
    return await apiSource.addCategory(name);
  }

  Future<dynamic> addCategoryWord(String name, String categoryId) async {
    final apiSource = ApiProvider();
    return await apiSource.addCategoryWord(name, categoryId);
  }

  Future<WordModel?> updateCategoryWord(
      String name, String slug, String categoryId) async {
    final apiSource = ApiProvider();
    return await apiSource.updateCategoryWord(name, slug, categoryId);
  }

  Future<CategoryModel?> updateCategory(String name, String slug) async {
    final apiSource = ApiProvider();
    return await apiSource.updateCategory(name, slug);
  }

  Future<String?> deleteCategoryWord(String slug) async {
    final apiSource = ApiProvider();
    return await apiSource.deleteCategoryWord(slug);
  }

  Future<String?> deleteCategory(String slug) async {
    final apiSource = ApiProvider();
    return await apiSource.deleteCategory(slug);
  }
}

abstract class Source {
  Future<CategoryModel?> addCategory(String name);
  Future<dynamic> addCategoryWord(String name, String categoryId);
  Future<WordModel?> updateCategoryWord(
      String name, String slug, String categoryId);
}

abstract class Cache {
  Future<int> addItem(CategoryModel item);
  Future<int> clear();
}
