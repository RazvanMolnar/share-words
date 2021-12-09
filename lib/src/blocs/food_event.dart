import 'package:equatable/equatable.dart';

abstract class FoodEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCategory extends FoodEvent {
  final String name;

  AddCategory({required this.name});

  @override
  List<Object> get props => [name];
}

class AddCategoryWord extends FoodEvent {
  final String name;
  final String categoryId;

  AddCategoryWord({required this.name, required this.categoryId});

  @override
  List<Object> get props => [name, categoryId];
}

class UpdateCategory extends FoodEvent {
  final String name;
  final String slug;

  UpdateCategory({required this.name, required this.slug});

  @override
  List<Object> get props => [name, slug];
}

class UpdateCategoryWord extends FoodEvent {
  final String name;
  final String slug;
  final String categoryId;

  UpdateCategoryWord(
      {required this.name, required this.slug, required this.categoryId});

  @override
  List<Object> get props => [name, slug, categoryId];
}

class DeleteCategoryWord extends FoodEvent {
  final String slug;
  DeleteCategoryWord({required this.slug});

  @override
  List<Object> get props => [slug];
}

class DeleteCategory extends FoodEvent {
  final String slug;
  DeleteCategory({required this.slug});

  @override
  List<Object> get props => [slug];
}

class CategoryGet extends FoodEvent {
  final String categorySlug;

  CategoryGet({required this.categorySlug});

  @override
  List<Object> get props => [categorySlug];
}
