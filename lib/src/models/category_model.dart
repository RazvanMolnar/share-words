import 'package:equatable/equatable.dart';
import 'dart:convert';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String slug;
  int? numOfWords = 0;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.numOfWords,
  });

  @override
  List<Object?> get props => [id, name, slug, numOfWords];

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'slug': slug, 'numOfWords': numOfWords};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['_id'],
        name: map['name'],
        slug: map['slug'],
        numOfWords: map['numOfWords']);
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return "($id,$name,$slug)";
  }
}

// Our demo category
List<CategoryModel> categories = [
  CategoryModel(
    id: "1",
    name: "Animale",
    slug: "animale",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "2",
    name: "Obiecte",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "3",
    name: "Vehicule",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "4",
    name: "Altele",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "5",
    name: "Obiecte5",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "6",
    name: "Vehicule6",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "7",
    name: "Altele7",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "8",
    name: "Obiecte8",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "9",
    name: "Vehicule9",
    slug: "obiecte",
    numOfWords: 100,
  ),
  CategoryModel(
    id: "10",
    name: "Altele10",
    slug: "obiecte",
    numOfWords: 100,
  ),
];
