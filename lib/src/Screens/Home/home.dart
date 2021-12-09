import 'package:filip/src/Screens/Home/food_screen.dart';
import 'package:filip/src/Screens/Home/home_screen.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeCategoriesScreen(),
    const HomeFoodScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numOfWeeks(int year) {
      DateTime dec28 = DateTime(year, 12, 28);
      int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
      return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
    }

    /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    int weekNumber(DateTime date) {
      int dayOfYear = int.parse(DateFormat("D").format(date));
      int woy = ((dayOfYear - date.weekday + 10) / 7).floor();
      if (woy < 1) {
        woy = numOfWeeks(date.year - 1);
      } else if (woy > numOfWeeks(date.year)) {
        woy = 1;
      }
      return woy;
    }

    final date = DateTime.now();
    final startOfYear = DateTime(date.year, 1, 1, 0, 0);

    final firstMonday = startOfYear.weekday;
    var weeks = weekNumber(date.add(Duration(days: -7)));
    print(
        "Start Date for week $weeks: ${startOfYear.add(Duration(days: 7 * weeks - firstMonday + 1))}");
    print(
        "End Date for week $weeks: ${startOfYear.add(Duration(days: 7 * weeks + 7 - firstMonday))}");

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        // backgroundColor: Colors.redAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.textsms_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood_rounded), label: '')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyConstants.mainPrimaryTextColor,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
        child: _widgetOptions[_selectedIndex],
      ),
    );
  }
}
