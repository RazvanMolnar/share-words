import 'package:equatable/equatable.dart';
import 'package:filip/src/models/category_model.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryAddSuccess extends CategoryState {
  final String message;
  final CategoryModel category;

  CategoryAddSuccess({required this.message, required this.category});

  @override
  List<Object> get props => [message, category];
}

class CategoryUpdateSuccess extends CategoryState {
  final String message;
  final CategoryModel category;

  CategoryUpdateSuccess({required this.message, required this.category});

  @override
  List<Object> get props => [message, category];
}

class CategoryUpdateFailure extends CategoryState {
  final String error;

  CategoryUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CategoryWordInitial extends CategoryState {}

class CategoryWordLoading extends CategoryState {}

class CategoryWordUpdateSuccess extends CategoryState {
  final String message;

  CategoryWordUpdateSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class CategoryWordUpdateFailure extends CategoryState {
  final String error;

  CategoryWordUpdateFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteCategoryWordSuccess extends CategoryState {
  final String message;

  DeleteCategoryWordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCategoryWordFailure extends CategoryState {
  final String error;

  DeleteCategoryWordFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteCategorySuccess extends CategoryState {
  final String message;

  DeleteCategorySuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteCategoryFailure extends CategoryState {
  final String error;

  DeleteCategoryFailure({required this.error});

  @override
  List<Object> get props => [error];
}
