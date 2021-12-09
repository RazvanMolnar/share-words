import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:filip/src/models/chart_model.dart';

class DeveloperChart extends StatelessWidget {
  final List<DeveloperSeries> data;
  const DeveloperChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<charts.Series<DeveloperSeries, String>> series = [
      charts.Series(
          id: "pe_luni",
          data: data,
          domainFn: (DeveloperSeries series, _) => series.year,
          measureFn: (DeveloperSeries series, _) => series.developers,
          colorFn: (DeveloperSeries series, _) => series.barColor)
    ];

    return Container(
      height: size.height * 0.25,
      // padding: const EdgeInsets.all(MyConstants.defaultScreenPadding / 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(MyConstants.screenPadding),
          child: Column(
            children: <Widget>[
              Text(
                "Nr de cuvinte noi",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
