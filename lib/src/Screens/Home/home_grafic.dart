// import 'package:filip/src/Screens/Category/category_screen.dart';
// import 'package:filip/src/Screens/Words/words_screen.dart';
// import 'package:filip/src/blocs/category.dart';
// import 'package:filip/src/models/category_model.dart';
// import 'package:filip/src/models/chart_model.dart';
// import 'package:filip/src/models/word_model.dart';
// import 'package:filip/src/resources/fetch_categories.dart';
// import 'package:filip/src/utils/chart.dart';
// import 'package:filip/src/utils/color_constants.dart';
// import 'package:filip/src/utils/line_chart.dart';
// import 'package:filip/src/utils/rounded_input_field.dart';
// import 'package:filip/src/utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class HomeScreen extends StatefulWidget {
//   static const routeName = '/';
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int selectedIndex = 0;

//   final List<DeveloperSeries> data = [
//     DeveloperSeries(
//       year: "06/21",
//       developers: 40000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "07/21",
//       developers: 5000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "08/21",
//       developers: 40000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "09/21",
//       developers: 35000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//   ];

//   final List<DeveloperSeries> dataLine = [
//     DeveloperSeries(
//       year: "06/21",
//       year2: 2016,
//       developers: 40000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "06/21",
//       year2: 2017,
//       developers: 5000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "06/21",
//       year2: 2018,
//       developers: 40000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//     DeveloperSeries(
//       year: "06/21",
//       year2: 2019,
//       developers: 35000,
//       barColor: charts.ColorUtil.fromDartColor(Colors.green),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormBuilderState>();
//     final _nameController = TextEditingController();
//     final _categoryBloc = BlocProvider.of<CategoryBloc>(context);

//     _onSubmitNewCategory() {
//       if (_formKey.currentState!.validate()) {
//         _categoryBloc.add(
//           AddCategory(
//             name: _nameController.text,
//           ),
//         );
//       }
//     }

//     return Scaffold(
//       body: SafeArea(
//         minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
//         child: SingleChildScrollView(
//           child: BlocListener<CategoryBloc, CategoryState>(
//             listener: (context, state) {
//               if (state is CategoryUpdateFailure) {
//                 Utils.showMessage(context, state.error);
//               }

//               if (state is CategoryUpdateSuccess) {
//                 Utils.showMessage(context, state.message);
//               }
//             },
//             child: BlocBuilder<CategoryBloc, CategoryState>(
//                 builder: (context, state) {
//               if (state is CategoryLoading || state is CategoryInitial) {
//                 _nameController.text = "";
//               }

//               if (state is CategoryInitial) {
//                 return FormBuilder(
//                   autovalidateMode: AutovalidateMode.disabled,
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: MyConstants.defaultScreenPadding),
//                       ListTile(
//                         leading: const CircleAvatar(
//                           radius: 30.0,
//                           backgroundImage:
//                               AssetImage("assets/images/filip.jpg"),
//                           backgroundColor: Colors.transparent,
//                         ),
//                         title: Text(
//                           "Filip",
//                           style:
//                               Theme.of(context).textTheme.headline5!.copyWith(
//                                     color: MyConstants.secondaryTextColor,
//                                     fontFamily: 'LibreBaskerville',
//                                   ),
//                         ),
//                         subtitle: Text(
//                           "1an juma'",
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline6!
//                               .copyWith(
//                                   color: MyConstants.mainPrimaryTextColor),
//                         ),
//                         trailing: FutureBuilder(
//                           future: fetchTotal(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Text(
//                                 "${snapshot.data} cuvinte",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5!
//                                     .copyWith(
//                                         color: MyConstants.secondaryTextColor,
//                                         fontFamily: 'LibreBaskerville'),
//                               );
//                             }

//                             return Text(
//                               "0 cuvinte",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline5!
//                                   .copyWith(
//                                       color: MyConstants.secondaryTextColor,
//                                       fontFamily: 'LibreBaskerville'),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: MyConstants.screen10Padding),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: RoundedInputField(
//                               hintText: "Adauga categorie",
//                               onChanged: (value) {},
//                               keyboardType: TextInputType.text,
//                               controller: _nameController,
//                             ),
//                           ),
//                           const SizedBox(width: MyConstants.screen10Padding),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: MyConstants.greenColor,
//                               padding: const EdgeInsets.symmetric(
//                                 vertical: MyConstants.screen10Padding,
//                                 horizontal: MyConstants.defaultScreenPadding,
//                               ),
//                               textStyle: const TextStyle(fontSize: 20),
//                             ),
//                             onPressed: _onSubmitNewCategory,
//                             child: const Text(
//                               "+",
//                               style: TextStyle(color: MyConstants.thirdColor),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     // ElevatedButton.icon(
//                       //     //   onPressed: () {},
//                       //     //   icon: const Icon(Icons.add),
//                       //     //   label: const Text(
//                       //     //     "categorie",
//                       //     //     style: TextStyle(color: MyConstants.mainPrimaryTextColor),
//                       //     //   ),
//                       //     // ),
//                       //     ElevatedButton(
//                       //       style: ElevatedButton.styleFrom(
//                       //         primary: MyConstants.thirdColor,
//                       //         padding: const EdgeInsets.symmetric(
//                       //           vertical: MyConstants.screen10Padding,
//                       //           horizontal: MyConstants.defaultScreenPadding,
//                       //         ),
//                       //         textStyle: const TextStyle(fontSize: 16),
//                       //       ),
//                       //       onPressed: () {},
//                       //       child: const Text(
//                       //         "+ categorie",
//                       //         style:
//                       //             TextStyle(color: MyConstants.mainPrimaryTextColor),
//                       //       ),
//                       //     ),
//                       //     ElevatedButton(
//                       //       style: ElevatedButton.styleFrom(
//                       //         primary: MyConstants.thirdColor,
//                       //         padding: const EdgeInsets.symmetric(
//                       //           vertical: MyConstants.screen10Padding,
//                       //           horizontal: MyConstants.defaultScreenPadding,
//                       //         ),
//                       //         textStyle: const TextStyle(fontSize: 16),
//                       //       ),
//                       //       onPressed: () {
//                       //         Navigator.pushNamed(
//                       //           context,
//                       //           WordsScreen.routeName,
//                       //         );
//                       //       },
//                       //       child: const Text(
//                       //         "+ cuvant",
//                       //         style:
//                       //             TextStyle(color: MyConstants.mainPrimaryTextColor),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // RoundedInputField(
//                       //   hintText: "Adauga cuvant",
//                       //   onChanged: (value) {},
//                       //   keyboardType: TextInputType.text,
//                       //   controller: _searchController,
//                       // ),
//                       // DeveloperChart(
//                       //   data: data,
//                       // ),
//                       const SizedBox(height: MyConstants.screen10Padding),
//                       // DeveloperLineChart(
//                       //   data: dataLine,
//                       // ),
//                       const SizedBox(height: MyConstants.defaultScreenPadding),
//                       FutureBuilder(
//                         future: fetchCategories(),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             List<CategoryModel> apiCategories =
//                                 snapshot.data as List<CategoryModel>;
//                             return Wrap(
//                               children: apiCategories
//                                   .map((item) => buildCategory2(item))
//                                   .toList()
//                                   .cast<Widget>(),
//                             );
//                           }

//                           return const Center(
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return const Center(child: CircularProgressIndicator());
//             }),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildCategory2(CategoryModel category) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           CategoryScreen.routeName,
//           arguments: category,
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(0, 0, MyConstants.screen10Padding / 2,
//             MyConstants.screen10Padding / 2),
//         padding: const EdgeInsets.symmetric(
//           horizontal: MyConstants.defaultScreenPadding / 2,
//           vertical: MyConstants.defaultScreenPadding / 5,
//         ),
//         decoration: BoxDecoration(
//           color: MyConstants.mainPrimaryInputBgColor,
//           borderRadius: BorderRadius.circular(MyConstants.defaultScreenPadding),
//           border: Border.all(color: MyConstants.thirdColor),
//         ),
//         child: Text(
//           "${category.name} (${category.numOfWords})",
//           style: Theme.of(context)
//               .textTheme
//               .bodyText1!
//               .copyWith(color: MyConstants.secondaryTextColor),
//         ),
//       ),
//     );
//   }
// }
