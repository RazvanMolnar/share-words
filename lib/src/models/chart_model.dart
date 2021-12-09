import 'package:charts_flutter/flutter.dart' as charts;

class DeveloperSeries {
  final String year;
  final int? year2;
  final int developers;
  final charts.Color barColor;

  DeveloperSeries({
    required this.year,
    this.year2,
    required this.developers,
    required this.barColor,
  });
}
