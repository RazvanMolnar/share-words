import 'package:filip/src/Screens/Category/category_screen.dart';
import 'package:filip/src/Screens/DailyFood/daily_food_screen.dart';
// import 'package:filip/src/Screens/DailyFood/weekly_print_screen.dart';
import 'package:filip/src/Screens/Home/home.dart';
import 'package:filip/src/Screens/Words/words_screen.dart';
import 'package:filip/src/blocs/category.dart';
import 'package:filip/src/blocs/food.dart';
import 'package:filip/src/blocs/simple.dart';
import 'package:filip/src/api/repository.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Repository>(
          create: (context) => Repository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider<AuthenticationBloc>(
          //   create: (context) {
          //     final authService =
          //         RepositoryProvider.of<AuthenticationService>(context);
          //     print('MultiBlocProvider => AppLoaded()');
          //     return AuthenticationBloc(authService)..add(AppLoaded());
          //   },
          // ),
          BlocProvider<CategoryBloc>(
            create: (context) {
              final repository = RepositoryProvider.of<Repository>(context);
              return CategoryBloc(repository);
            },
          ),
          BlocProvider<FoodBloc>(
            create: (context) {
              final repository = RepositoryProvider.of<Repository>(context);
              return FoodBloc(repository);
            },
          ),
          BlocProvider<SimpleInformationBloc>(
            create: (context) {
              final repository = RepositoryProvider.of<Repository>(context);
              return SimpleInformationBloc(repository);
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime birthdate = DateFormat('yyyy-MM-dd').parse('2020-05-27');
    final dif = (DateTime.now().difference(birthdate).inHours / 24).round();

    final int differenceInYears = (dif ~/ 365);
    final int differenceInMonths = (dif - differenceInYears * 365) ~/ 30;

    final _simpleInfoBloc = BlocProvider.of<SimpleInformationBloc>(context);
    _simpleInfoBloc.add(
      SimpleInformation(
        differenceInMonths: differenceInMonths,
        differenceInYears: differenceInYears,
        totalWords: 0,
      ),
    );

    print('================ main.dart');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filip',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
        canvasColor: Colors.transparent,
        primaryColor: MyConstants.mainPrimaryTextColor,
        scaffoldBackgroundColor: MyConstants.mainPrimaryBackgroundColor,
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 30.0),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
      ),
      home: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      routes: {
        CategoryScreen.routeName: (ctx) => CategoryScreen(),
        WordsScreen.routeName: (ctx) => const WordsScreen(),
        DailyFoodScreen.routeName: (ctx) => const DailyFoodScreen()
      },
    );
  }
}
