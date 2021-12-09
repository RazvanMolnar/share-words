import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:filip/src/models/chart_model.dart';

class DeveloperLineChart extends StatelessWidget {
  final List<DeveloperSeries> data;
  const DeveloperLineChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<charts.Series<DeveloperSeries, num>> series = [
      charts.Series(
          id: "pe_luni",
          data: data,
          domainFn: (DeveloperSeries series, _) => series.year2!,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor)
    ];

    return Container(
      height: size.height * 0.3,
      // padding: const EdgeInsets.all(MyConstants.defaultScreenPadding / 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(MyConstants.screenPadding),
          child: Column(
            children: <Widget>[
              Text(
                "Info grafic",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.LineChart(series,
                    domainAxis: const charts.NumericAxisSpec(
                      tickProviderSpec:
                          charts.BasicNumericTickProviderSpec(zeroBound: false),
                      viewport: charts.NumericExtents(2016.0, 2022.0),
                    ),
                    animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
