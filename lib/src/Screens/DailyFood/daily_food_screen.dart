import 'package:filip/src/Screens/DailyFood/weekly_print_screen.dart';
import 'package:filip/src/blocs/food.dart';
import 'package:filip/src/models/week_days_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class DailyFoodScreen extends StatefulWidget {
  static const routeName = '/daily';
  const DailyFoodScreen({Key? key}) : super(key: key);

  @override
  _DailyFoodScreenState createState() => _DailyFoodScreenState();
}

class _DailyFoodScreenState extends State<DailyFoodScreen> {
  late WeeksModel weekModel;
  late Future<List<WeekDaysModel>?> _weekDays;

  @override
  void initState() {
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      setState(() {
        weekModel = ModalRoute.of(context)!.settings.arguments as WeeksModel;
      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _nameController = TextEditingController();
    final _categNameController = TextEditingController();
    final _foodBloc = BlocProvider.of<FoodBloc>(context);

    _onSubmitNewWord() {
      if (_formKey.currentState!.validate()) {
        _foodBloc.add(
          AddCategoryWord(
            name: _nameController.text,
            categoryId: weekModel.weekNr.toString(),
          ),
        );
      }
    }

    _onSubmitUpdateCateg() {
      _foodBloc.add(
        UpdateCategory(
          name: _categNameController.text,
          slug: weekModel.weekNr.toString(),
        ),
      );
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyConstants.secondaryTextColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          weekModel.dates,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: MyConstants.defaultScreenPadding),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WeeklyPrintScreen(
                        week: weekModel, period: weekModel.dates),
                  ),
                );
              },
              child:
                  const Icon(Icons.print, color: MyConstants.secondInputColor),
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
        child: SingleChildScrollView(
          child: BlocListener<FoodBloc, FoodState>(
            listener: (context, state) {
              if (state is CategoryWordUpdateFailure) {
                Utils.showErrorMessage(context, state.error);
              } else if (state is DeleteCategoryWordFailure) {
                Utils.showErrorMessage(context, state.error);
              }
            },
            child: BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
              print(state);

              if (state is CategoryWordLoading || state is CategoryInitial) {
                _nameController.text = "";
              }

              if (state is CategoryInitial) {
                return FormBuilder(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                            height: MyConstants.defaultScreenPadding),
                        FutureBuilder(
                          future: fetchWeekDays(weekModel),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<WeekDaysModel> listOfWords =
                                  snapshot.data as List<WeekDaysModel>;

                              return Wrap(
                                children: listOfWords
                                    .map((item) => BuildDays(week: item))
                                    .toList()
                                    .cast<Widget>(),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        ),
                      ]),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
    );
  }
}

class BuildDays extends StatefulWidget {
  final WeekDaysModel week;
  const BuildDays({Key? key, required this.week}) : super(key: key);

  @override
  _BuildDaysState createState() => _BuildDaysState();
}

class _BuildDaysState extends State<BuildDays> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _bkfastController =
        TextEditingController(text: widget.week.breakfast);
    final _lunchController = TextEditingController(text: widget.week.lunch);
    final _dinnerController = TextEditingController(text: widget.week.dinner);
    final _snackController = TextEditingController(text: widget.week.snack);
    final _categNameController = TextEditingController();
    final _foodBloc = BlocProvider.of<FoodBloc>(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
          0, 0, 0, MyConstants.defaultScreenPadding / 2),
      padding: const EdgeInsets.symmetric(
        horizontal: MyConstants.defaultScreenPadding / 2,
        vertical: MyConstants.defaultScreenPadding / 5,
      ),
      decoration: BoxDecoration(
        color: MyConstants.mainPrimaryInputBgColor,
        borderRadius: BorderRadius.circular(MyConstants.screen10Padding),
        border: Border.all(color: MyConstants.thirdColor),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isActive = !isActive;
              });
            },
            child: ListTile(
              minVerticalPadding: 0,
              minLeadingWidth: 0,
              horizontalTitleGap: 0,
              title: Text(
                DateFormat('EEEE, d MMM yyyy').format(widget.week.day),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: MyConstants.secondaryTextColor, fontSize: 15.0),
              ),
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              trailing: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: MyConstants.secondaryTextColor),
            ),
          ),
          isActive
              ? Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Micul dejun",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: MyConstants.secondaryTextColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   WordsScreen.routeName,
                                //   arguments: word,
                                // );
                              },
                              child: Text(
                                widget.week.breakfast,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Pranz",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: MyConstants.secondaryTextColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   WordsScreen.routeName,
                                //   arguments: word,
                                // );
                              },
                              child: Text(
                                widget.week.lunch,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Cina",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: MyConstants.secondaryTextColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   WordsScreen.routeName,
                                //   arguments: word,
                                // );
                              },
                              child: Text(
                                widget.week.dinner,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 100,
                            child: Text(
                              "Snack",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: MyConstants.secondaryTextColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigator.pushNamed(
                                //   context,
                                //   WordsScreen.routeName,
                                //   arguments: word,
                                // );
                              },
                              child: Text(
                                widget.week.snack,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const SizedBox(height: 1),
          isActive
              ? const SizedBox(height: MyConstants.defaultScreenPadding)
              : const SizedBox(height: 1),
        ],
      ),
    );
  }
}
