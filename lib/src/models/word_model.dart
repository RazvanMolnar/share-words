import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:filip/src/models/category_model.dart';

class WordModel extends Equatable {
  final String id;
  final String name;
  final String slug;
  final CategoryModel category;
  DateTime? createdAt = DateTime.now();
  DateTime? updatedAt = DateTime.now();

  WordModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, slug, category, createdAt, updatedAt];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['_id'],
      name: map['name'],
      slug: map['slug'],
      category: CategoryModel.fromMap(map['category']),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) =>
      WordModel.fromMap(json.decode(source));

  @override
  String toString() {
    return "($id,$name,$slug,$category)";
  }
}

// Our demo category
List<WordModel> words = [
  WordModel(
    id: "1",
    name: "Hipopotam",
    slug: "hipopotam",
    category: CategoryModel(
      id: "1",
      name: "Animale",
      slug: "animale",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "2",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      slug: "obiecte",
      name: "Obiecte",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "3",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      slug: "obiecte",
      name: "Obiecte",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "4",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      name: "Obiecte",
      slug: "obiecte",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "5",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      name: "Obiecte",
      slug: "obiecte",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "6",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      name: "Obiecte",
      slug: "obiecte",
      numOfWords: 100,
    ),
  ),
  WordModel(
    id: "6",
    name: "Animale",
    slug: "hipopotam",
    category: CategoryModel(
      id: "2",
      name: "Obiecte",
      slug: "obiecte",
      numOfWords: 100,
    ),
  ),
];
