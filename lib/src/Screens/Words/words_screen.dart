import 'package:filip/src/Screens/Home/home.dart';
import 'package:filip/src/blocs/category.dart';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/models/word_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/rounded_input_field.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class WordsScreen extends StatefulWidget {
  static const routeName = '/words';

  const WordsScreen({Key? key}) : super(key: key);

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  String categoryId = "";
  WordModel? word;
  late Future<List<CategoryModel>?> _categories;

  @override
  void initState() {
    _categories = fetchCategories();
    super.initState();
    // future that allows us to access context. function is called inside the future
    // otherwise it would be skipped and args would return null
    Future.delayed(Duration.zero, () {
      setState(() {
        word = ModalRoute.of(context)!.settings.arguments as WordModel;
        categoryId = word?.category.id ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final _nameController = TextEditingController(text: word?.name ?? "");
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _onSubmitWord() {
      if (_formKey.currentState!.validate()) {
        _categoryBloc.add(
          UpdateCategoryWord(
            name: _nameController.text,
            slug: word!.slug,
            categoryId: categoryId,
          ),
        );

        _categories = fetchCategories();
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: MyConstants.blueColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: MyConstants.mainPrimaryInputBgColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // title: Text(
          //   "${word?.name ?? ""}",
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline6!
          //       .copyWith(color: MyConstants.greenColor),
          // ),
          title: Padding(
            padding:
                const EdgeInsets.only(left: MyConstants.defaultScreenPadding),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: const Icon(
                Icons.home,
                color: MyConstants.mainPrimaryInputBgColor,
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstants.mainPrimaryInputBgColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: MyConstants.screen10Padding,
                      horizontal: MyConstants.defaultScreenPadding,
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _categoryBloc.add(
                      DeleteCategoryWord(slug: word!.slug),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "delete",
                    style: TextStyle(color: MyConstants.redColor),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
          child: SingleChildScrollView(
            child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
              print(state);

              if (state is CategoryInitial) {
                return FormBuilder(
                    autovalidateMode: AutovalidateMode.disabled,
                    key: _formKey,
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                                height: MyConstants.defaultScreenPadding * 2),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedInputField(
                                    hintText: "Editeaza cuvant",
                                    onChanged: (value) {},
                                    keyboardType: TextInputType.text,
                                    controller: _nameController,
                                  ),
                                ),
                                const SizedBox(
                                    width: MyConstants.screen10Padding),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        MyConstants.mainPrimaryInputBgColor,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: MyConstants.screen10Padding,
                                      horizontal:
                                          MyConstants.defaultScreenPadding,
                                    ),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: _onSubmitWord,
                                  child: const Text(
                                    "SAVE",
                                    style: TextStyle(
                                        color: MyConstants.greenColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: MyConstants.screen10Padding),
                            FutureBuilder(
                              future: _categories,
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
                                } else if (snapshot.hasError) {
                                  return Column(children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 60,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text('Error: ${snapshot.error}'),
                                    )
                                  ]);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2));
                                }
                              },
                            ),
                            const SizedBox(height: MyConstants.screen10Padding),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     primary: MyConstants.greenColor,
                            //     padding: const EdgeInsets.symmetric(
                            //       vertical: MyConstants.screen10Padding,
                            //       horizontal: MyConstants.defaultScreenPadding,
                            //     ),
                            //     textStyle: const TextStyle(fontSize: 20),
                            //   ),
                            //   onPressed: _onSubmitWord,
                            //   child: const Text(
                            //     "save",
                            //     style: TextStyle(color: MyConstants.thirdColor),
                            //   ),
                            // ),
                          ]),
                    ));
              }

              return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2));
            }),
          ),
        ));
  }

  Widget buildCategory2(CategoryModel category) {
    return InkWell(
      onTap: () {
        setState(() {
          categoryId = category.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, MyConstants.screen10Padding / 2,
            MyConstants.screen10Padding / 2),
        padding: const EdgeInsets.symmetric(
          horizontal: MyConstants.defaultScreenPadding / 2,
          vertical: MyConstants.defaultScreenPadding / 5,
        ),
        decoration: BoxDecoration(
          color: categoryId == category.id
              ? MyConstants.secondaryTextColor
              : MyConstants.mainPrimaryInputBgColor,
          borderRadius: BorderRadius.circular(MyConstants.screen10Padding),
          border: Border.all(color: MyConstants.thirdColor),
        ),
        child: Text(
          "${category.name} (${category.numOfWords})",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: categoryId == category.id
                  ? MyConstants.mainPrimaryInputBgColor
                  : MyConstants.secondaryTextColor,
              fontSize: 18.0),
        ),
      ),
    );
  }
}
