import 'package:equatable/equatable.dart';

abstract class SimpleState extends Equatable {
  @override
  List<Object> get props => [];
}

class SimpleInformationInitial extends SimpleState {
  final int months;
  final int years;

  SimpleInformationInitial({required this.months, required this.years});

  @override
  List<Object> get props => [];
}

class SimpleInformationLoading extends SimpleState {}
