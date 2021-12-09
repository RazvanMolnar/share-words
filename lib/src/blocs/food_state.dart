import 'package:equatable/equatable.dart';
import 'package:filip/src/models/category_model.dart';

abstract class FoodState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends FoodState {}

class CategoryLoading extends FoodState {}

class CategoryAddSuccess extends FoodState {
  final String message;
  final CategoryModel category;

  CategoryAddSuccess({required this.message, required this.category});

  @override
  List<Object> get props => [message, category];
}

class CategoryUpdateSuccess extends FoodState {
  final String message;
  final CategoryModel category;

  CategoryUpdateSuccess({required this.message, required this.category});

  @override
  List<Object> get props => [message, category];
}

class CategoryUpdateFailure extends FoodState {
  final String error;

  CategoryUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoryWordInitial extends FoodState {}

class CategoryWordLoading extends FoodState {}

class CategoryWordUpdateSuccess extends FoodState {
  final String message;

  CategoryWordUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CategoryWordUpdateFailure extends FoodState {
  final String error;

  CategoryWordUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteCategoryWordSuccess extends FoodState {
  final String message;

  DeleteCategoryWordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCategoryWordFailure extends FoodState {
  final String error;

  DeleteCategoryWordFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteCategorySuccess extends FoodState {
  final String message;

  DeleteCategorySuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCategoryFailure extends FoodState {
  final String error;

  DeleteCategoryFailure({required this.error});

  @override
  List<Object> get props => [error];
}
