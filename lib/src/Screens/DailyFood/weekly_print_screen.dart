import 'package:filip/src/models/week_days_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class WeeklyPrintScreen extends StatefulWidget {
  static const routeName = '/print';
  final WeeksModel week;
  final String period;

  const WeeklyPrintScreen({Key? key, required this.week, required this.period})
      : super(key: key);

  @override
  State<WeeklyPrintScreen> createState() => _WeeklyPrintScreenState();
}

class _WeeklyPrintScreenState extends State<WeeklyPrintScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.week);
    print(MediaQuery.of(context).orientation);

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: MyConstants.secondaryTextColor,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text(
      //     widget.period,
      //     style: Theme.of(context)
      //         .textTheme
      //         .headline6!
      //         .copyWith(color: Colors.black),
      //   ),
      //   actions: [],
      // ),
      body: SafeArea(
        minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
        child: SingleChildScrollView(
          child: MediaQuery.of(context).orientation == Orientation.landscape
              ? Column(
                  children: [
                    FutureBuilder(
                      future: fetchWeekDays(widget.week),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<WeekDaysModel> listOfWords =
                              snapshot.data as List<WeekDaysModel>;

                          return Wrap(
                            children: listOfWords
                                .map((item) => _buildDay(context, item))
                                .toList()
                                .cast<Widget>(),
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                    ),
                  ],
                )
              : const Center(child: Text('Landscape')),
        ),
      ),
    );
  }

  Widget _buildDay(BuildContext context, WeekDaysModel day) {
    Size size = MediaQuery.of(context).size;
    double sizeContainer = (MediaQuery.of(context).size.width - 90) / 4;

    return Padding(
      padding: const EdgeInsets.only(bottom: 1.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
        decoration: const BoxDecoration(
          color: MyConstants.mainPrimaryInputBgColor,
          // border: Border(
          //   bottom: BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 2.0,
                      color: MyConstants.mainPrimaryBackgroundColor),
                ),
              ),
              width: 50,
              child: Text(
                DateFormat('E, d MMM ').format(day.day),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: MyConstants.secondaryTextColor, fontSize: 11.0),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 2.0,
                      color: MyConstants.mainPrimaryBackgroundColor),
                ),
              ),
              width: sizeContainer,
              child: Text(
                day.breakfast,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 11.0),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 2.0,
                      color: MyConstants.mainPrimaryBackgroundColor),
                ),
              ),
              width: sizeContainer,
              child: Text(
                day.lunch,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 11.0),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 2.0,
                      color: MyConstants.mainPrimaryBackgroundColor),
                ),
              ),
              width: sizeContainer,
              child: Text(
                day.dinner,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 11.0),
              ),
            ),
            Container(
              width: sizeContainer,
              child: Text(
                day.snack,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
