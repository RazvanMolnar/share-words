import 'package:filip/src/Screens/Category/category_screen.dart';
import 'package:filip/src/Screens/DailyFood/daily_food_screen.dart';
import 'package:filip/src/blocs/food.dart';
import 'package:filip/src/models/week_days_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeFoodScreen extends StatefulWidget {
  const HomeFoodScreen({Key? key}) : super(key: key);

  @override
  _HomeFoodScreenState createState() => _HomeFoodScreenState();
}

class _HomeFoodScreenState extends State<HomeFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final DateTime birthdate = DateFormat('yyyy-MM-dd').parse('2020-05-27');
    final dif = (DateTime.now().difference(birthdate).inHours / 24).round();

    final int differenceInYears = (dif ~/ 365);
    final int differenceInMonths = (dif - differenceInYears * 365) ~/ 30;

    return SingleChildScrollView(
      child: BlocListener<FoodBloc, FoodState>(
        listener: (context, state) {
          if (state is CategoryUpdateFailure) {
            Utils.showErrorMessage(context, state.error);
          } else if (state is CategoryAddSuccess) {
            Utils.showMessage(context, state.message);
            Navigator.pushNamed(
              context,
              CategoryScreen.routeName,
              arguments: state.category,
            );
          } else if (state is CategoryUpdateSuccess) {
            Utils.showMessage(context, state.message);
          } else if (state is DeleteCategorySuccess) {
            Utils.showMessage(context, state.message);
          } else if (state is DeleteCategoryFailure) {
            Utils.showErrorMessage(context, state.error);
          }
        },
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            if (state is CategoryInitial) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(height: MyConstants.defaultScreenPadding),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage("assets/images/filip.jpg"),
                        backgroundColor: Colors.redAccent,
                      ),
                      title: Text(
                        "Filip",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: MyConstants.secondaryTextColor,
                              fontFamily: 'LibreBaskerville',
                            ),
                      ),
                      subtitle: Text(
                        "$differenceInYears an $differenceInMonths luni",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: MyConstants.mainPrimaryTextColor,
                            fontSize: 16.0),
                      ),
                      trailing: FutureBuilder(
                        future: fetchTotal(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data} cuvinte",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: MyConstants.secondaryTextColor,
                                      fontFamily: 'LibreBaskerville'),
                            );
                          }

                          return Text(
                            "0 cuvinte",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: MyConstants.secondaryTextColor,
                                    fontFamily: 'LibreBaskerville'),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: MyConstants.screen10Padding),
                  Wrap(
                    children: weeks
                        .map((item) => buildCategory2(item))
                        .toList()
                        .cast<Widget>(),
                  )
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildCategory2(WeeksModel week) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DailyFoodScreen.routeName,
          arguments: week,
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, MyConstants.screen10Padding / 2,
            MyConstants.screen10Padding / 2),
        padding: const EdgeInsets.symmetric(
          horizontal: MyConstants.defaultScreenPadding,
          vertical: MyConstants.defaultScreenPadding / 2,
        ),
        decoration: BoxDecoration(
          color: MyConstants.mainPrimaryInputBgColor,
          borderRadius: BorderRadius.circular(MyConstants.screen10Padding),
          border: Border.all(color: MyConstants.thirdColor),
        ),
        child: Text(
          week.dates,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyConstants.secondaryTextColor, fontSize: 15.0),
        ),
      ),
    );
  }
}
