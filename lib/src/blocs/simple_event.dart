import 'package:equatable/equatable.dart';

abstract class SimpleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SimpleInformation extends SimpleEvent {
  final int differenceInYears;
  final int differenceInMonths;
  final int totalWords;

  SimpleInformation({
    required this.differenceInYears,
    required this.differenceInMonths,
    required this.totalWords,
  });

  @override
  List<Object> get props => [differenceInYears, differenceInMonths, totalWords];
}
