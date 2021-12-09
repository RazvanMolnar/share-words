import 'package:filip/src/Screens/Category/category_screen.dart';
import 'package:filip/src/blocs/category.dart';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/rounded_input_field.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class HomeCategoriesScreen extends StatefulWidget {
  const HomeCategoriesScreen({Key? key}) : super(key: key);

  @override
  _HomeCategoriesScreenState createState() => _HomeCategoriesScreenState();
}

class _HomeCategoriesScreenState extends State<HomeCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _nameController = TextEditingController();
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _onSubmitNewCategory() {
      if (_formKey.currentState!.validate()) {
        _categoryBloc.add(
          AddCategory(
            name: _nameController.text,
          ),
        );
      }
    }

    final DateTime birthdate = DateFormat('yyyy-MM-dd').parse('2020-05-27');
    final dif = (DateTime.now().difference(birthdate).inHours / 24).round();

    final int differenceInYears = (dif ~/ 365);
    final int differenceInMonths = (dif - differenceInYears * 365) ~/ 30;

    return SingleChildScrollView(
      child: BlocListener<CategoryBloc, CategoryState>(
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
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          if (state is CategoryLoading || state is CategoryInitial) {
            _nameController.text = "";
          }

          if (state is CategoryInitial) {
            return FormBuilder(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
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
                        "${differenceInYears} an ${differenceInMonths} luni",
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
                  Row(
                    children: [
                      Expanded(
                        child: RoundedInputField(
                          hintText: "Adauga categorie",
                          onChanged: (value) {},
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                        ),
                      ),
                      const SizedBox(width: MyConstants.screen10Padding),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MyConstants.greenColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: MyConstants.screen10Padding,
                            horizontal: MyConstants.defaultScreenPadding,
                          ),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: _onSubmitNewCategory,
                        child: const Text(
                          "+",
                          style: TextStyle(color: MyConstants.thirdColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MyConstants.defaultScreenPadding * 2),
                  FutureBuilder(
                    future: fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CategoryModel> apiCategories =
                            snapshot.data as List<CategoryModel>;
                        return Wrap(
                          children: apiCategories
                              .map((item) => buildCategory2(item))
                              .toList()
                              .cast<Widget>(),
                        );
                      }

                      if (snapshot.hasError) {
                        return AlertDialog(
                          title: const Text('Salutare'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Se pare ca serverul nu raspunde.')
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'hai ca l-am pornit',
                                style: TextStyle(
                                  color: MyConstants.redBorderColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget buildCategory2(CategoryModel category) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoryScreen.routeName,
          arguments: category,
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, MyConstants.screen10Padding / 2,
            MyConstants.screen10Padding / 2),
        padding: const EdgeInsets.symmetric(
          horizontal: MyConstants.defaultScreenPadding / 2,
          vertical: MyConstants.defaultScreenPadding / 5,
        ),
        decoration: BoxDecoration(
          color: MyConstants.mainPrimaryInputBgColor,
          borderRadius: BorderRadius.circular(MyConstants.screen10Padding),
          border: Border.all(color: MyConstants.thirdColor),
        ),
        child: Text(
          "${category.name} (${category.numOfWords})",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyConstants.secondaryTextColor, fontSize: 17.0),
        ),
      ),
    );
  }
}
