import 'package:filip/src/Screens/Words/words_screen.dart';
import 'package:filip/src/blocs/category.dart';
import 'package:filip/src/models/word_model.dart';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/api/fetch_categories.dart';
import 'package:filip/src/utils/color_constants.dart';
import 'package:filip/src/utils/rounded_input_field.dart';
import 'package:filip/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryModel? category;
  late List<WordModel>? _listOfWords;
  late int _listOfWordsLen = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var category = ModalRoute.of(context)!.settings.arguments as CategoryModel;

    final _formKey = GlobalKey<FormBuilderState>();
    final _nameController = TextEditingController();
    final _categNameController = TextEditingController(text: category.name);
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _onSubmitNewWord() {
      if (_formKey.currentState!.validate()) {
        _categoryBloc.add(
          AddCategoryWord(
            name: _nameController.text,
            categoryId: category.id,
          ),
        );
      }
    }

    _onSubmitUpdateCateg() {
      _categoryBloc.add(
        UpdateCategory(
          name: _categNameController.text,
          slug: category.slug,
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
          category.name,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          color: MyConstants.secondaryTextColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: MyConstants.defaultScreenPadding * 2,
                                horizontal: MyConstants.screen10Padding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Editeaza categoria:",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: MyConstants
                                                .mainPrimaryBackgroundColor,
                                            fontSize: 20.0)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RoundedInputField(
                                        hintText: "Editeaza categoria",
                                        onChanged: (value) {},
                                        keyboardType: TextInputType.text,
                                        controller: _categNameController,
                                      ),
                                    ),
                                    const SizedBox(
                                        width: MyConstants.screen10Padding),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: MyConstants.greenColor,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: MyConstants.screen10Padding,
                                          horizontal:
                                              MyConstants.defaultScreenPadding,
                                        ),
                                        textStyle:
                                            const TextStyle(fontSize: 20),
                                      ),
                                      onPressed: _onSubmitUpdateCateg,
                                      child: const Text(
                                        "SAVE",
                                        style: TextStyle(
                                            color: MyConstants.thirdColor),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.edit,
                    color: MyConstants.secondaryTextColor,
                  ),
                ),
              ),
              const SizedBox(width: MyConstants.screen10Padding),
              _listOfWordsLen == 0
                  ? InkWell(
                      onTap: () {
                        _categoryBloc.add(
                          DeleteCategory(slug: category.slug),
                        );
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.black,
                        child: Icon(
                          Icons.delete_outline,
                          color: MyConstants.secondaryTextColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(width: MyConstants.screen10Padding),
            ],
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(MyConstants.defaultScreenPadding / 2),
        child: SingleChildScrollView(
          child: BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryWordUpdateFailure) {
                Utils.showErrorMessage(context, state.error);
              } else if (state is DeleteCategoryWordFailure) {
                Utils.showErrorMessage(context, state.error);
              } else if (state is CategoryWordUpdateSuccess) {
                Utils.showMessage(context, state.message);
                Navigator.pushReplacementNamed(
                  context,
                  CategoryScreen.routeName,
                  arguments: category,
                );
              } else if (state is CategoryUpdateSuccess) {
                Utils.showMessage(context, state.message);
                Navigator.pushReplacementNamed(
                  context,
                  CategoryScreen.routeName,
                  arguments: state.category,
                );
              } else if (state is DeleteCategoryWordSuccess) {
                Utils.showMessage(context, state.message);
              }
            },
            child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
              // print(state);

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
                        const SizedBox(height: MyConstants.screen10Padding),
                        Row(
                          children: [
                            Expanded(
                              child: RoundedInputField(
                                hintText: "Adauga cuvant",
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
                              onPressed: _onSubmitNewWord,
                              child: const Text(
                                "+",
                                style: TextStyle(color: MyConstants.thirdColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: MyConstants.defaultScreenPadding * 2),
                        Center(
                          child: FutureBuilder(
                            future: fetchCategoryWords(category.slug),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<WordModel> listOfWords =
                                    snapshot.data as List<WordModel>;

                                return Wrap(
                                  children: listOfWords
                                      .map((item) =>
                                          buildWordsList(context, item))
                                      .toList()
                                      .cast<Widget>(),
                                );
                                // return Wrap(
                                //   children: listOfWords
                                //       .map(
                                //         (item) => Padding(
                                //           padding: const EdgeInsets.only(
                                //               right: 20.0),
                                //           child: InkWell(
                                //             onTap: () {
                                //               Navigator.pushNamed(
                                //                 context,
                                //                 WordsScreen.routeName,
                                //                 arguments: item,
                                //               );
                                //             },
                                //             child: Text(
                                //               item.name,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .headline6!
                                //                   .copyWith(
                                //                       color: MyConstants
                                //                           .secondaryTextColor),
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //       .toList()
                                //       .cast<Widget>(),
                                // );
                              }

                              return const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              );
                            },
                          ),
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

  Widget buildWordsList(BuildContext context, WordModel word) {
    final _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    _onSubmitDeleteWord() {
      _categoryBloc.add(
        DeleteCategoryWord(slug: word.slug),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          WordsScreen.routeName,
          arguments: word,
        );
      },
      onLongPress: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Sterge cuvantul?'),
          actions: <Widget>[
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
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MyConstants.redBorderColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: MyConstants.screen10Padding,
                      horizontal: MyConstants.defaultScreenPadding,
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context, 'da'),
                  child: const Text(
                    "Sterge",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ).then(
        (value) {
          if (value == 'da') {
            _onSubmitDeleteWord();
          }
        },
      ),
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
          word.name,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: MyConstants.secondaryTextColor, fontSize: 18.0),
        ),
      ),
    );
  }
}
