import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WeekDaysModel extends Equatable {
  final int weekNr;
  final DateTime day;
  final String breakfast;
  final String lunch;
  final String dinner;
  final String snack;

  const WeekDaysModel({
    required this.weekNr,
    required this.day,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
  });

  @override
  List<Object> get props => [weekNr, day, breakfast, lunch, dinner, snack];

  Map<String, dynamic> toMap() {
    return {
      'weekNr': weekNr,
      'day': day,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'snack': snack
    };
  }

  factory WeekDaysModel.fromMap(Map<String, dynamic> map) {
    return WeekDaysModel(
      weekNr: map['weekNr'],
      day: map['day'],
      breakfast: map['breakfast'],
      lunch: map['lunch'],
      dinner: map['dinner'],
      snack: map['snack'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekDaysModel.fromJson(String source) =>
      WeekDaysModel.fromMap(json.decode(source));

  @override
  String toString() {
    return "($weekNr,$day,$breakfast,$dinner, $snack)";
  }
}

class WeeksModel extends Equatable {
  final int weekNr;
  final String dates;

  const WeeksModel({required this.weekNr, required this.dates});

  @override
  List<Object> get props => [weekNr, dates];

  Map<String, dynamic> toMap() {
    return {'weekNr': weekNr, 'dates': dates};
  }

  factory WeeksModel.fromMap(Map<String, dynamic> map) {
    return WeeksModel(
      weekNr: map['weekNr'],
      dates: map['dates'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeksModel.fromJson(String source) =>
      WeeksModel.fromMap(json.decode(source));

  @override
  String toString() {
    return "($weekNr,$dates)";
  }
}

List<WeeksModel> weeks = [
  const WeeksModel(weekNr: 40, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 39, dates: "04 Oct - 10 Oct"),
  const WeeksModel(weekNr: 38, dates: "27 Sept - 02 Oct"),
  const WeeksModel(weekNr: 37, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 36, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 35, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 34, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 33, dates: "11 Oct - 17 Oct"),
  const WeeksModel(weekNr: 32, dates: "11 Oct - 17 Oct"),
];

List<WeekDaysModel> weekMenu = <WeekDaysModel>[
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-11'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-12'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-13'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-14'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-15'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-16'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
  WeekDaysModel(
    weekNr: 40,
    day: DateFormat('yyyy-MM-dd').parse('2021-10-17'),
    breakfast: "ou fiert, roșie, paine",
    lunch: "mazare cu legume",
    dinner: "mamaliga cu mozarella",
    snack: "struguri roze, banana, pruna",
  ),
];
