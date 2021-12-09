import 'package:bloc/bloc.dart';
import 'package:filip/src/exceptions/authentication_exception.dart';
import 'package:filip/src/models/category_model.dart';
import 'package:filip/src/models/word_model.dart';
import 'package:filip/src/api/repository.dart';
import 'food_event.dart';
import 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final Repository _repository;

  FoodBloc(Repository repository)
      : _repository = repository,
        super(CategoryInitial());

  @override
  Stream<FoodState> mapEventToState(FoodEvent event) async* {
    if (event is AddCategory) {
      yield* _mapAddCategoryToState(event);
    } else if (event is AddCategoryWord) {
      yield* _mapAddCategoryWordToState(event);
    } else if (event is UpdateCategoryWord) {
      yield* _mapUpdateCategoryWordToState(event);
    } else if (event is DeleteCategoryWord) {
      yield* _mapDeleteCategoryWordToState(event);
    } else if (event is DeleteCategory) {
      yield* _mapDeleteCategoryToState(event);
    } else if (event is UpdateCategory) {
      yield* _mapUpdateCategoryToState(event);
    }
  }

  Stream<FoodState> _mapAddCategoryToState(AddCategory event) async* {
    yield CategoryLoading();

    try {
      // yield CategoryUpdateSuccess(
      //     message: 'Categoria a fost adaugata cu succes');
      // yield CategoryUpdateFailure(error: 'Nu se poate adauga');

      final CategoryModel? category = await _repository.addCategory(event.name);
      if (category != null) {
        yield CategoryAddSuccess(
            message: 'Categoria a fost adaugata cu succes', category: category);
      } else {
        yield CategoryUpdateFailure(error: 'Nu se poate adauga');
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      print("momentan nu");
      yield CategoryUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      print(err.runtimeType);
      yield CategoryUpdateFailure(error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }

  Stream<FoodState> _mapUpdateCategoryWordToState(
      UpdateCategoryWord event) async* {
    yield CategoryWordLoading();

    try {
      // yield CategoryWordUpdateSuccess(message: 'Adaugat cu succes');
      // yield CategoryWordUpdateFailure(error: 'Nu se poate adauga');

      final WordModel? word = await _repository.updateCategoryWord(
          event.name, event.slug, event.categoryId);

      if (word != null) {
        yield CategoryWordUpdateSuccess(message: 'Updatat cu succes');
      } else {
        yield CategoryWordUpdateFailure(error: 'Nu se poate updata');
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      // print("altceva");
      yield CategoryWordUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      // print(err.runtimeType);
      yield CategoryWordUpdateFailure(
          error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }

  Stream<FoodState> _mapAddCategoryWordToState(AddCategoryWord event) async* {
    yield CategoryWordLoading();

    try {
      // yield CategoryWordUpdateSuccess(message: 'Adaugat cu succes');
      // yield CategoryWordUpdateFailure(error: 'Nu se poate adauga');

      final dynamic word =
          await _repository.addCategoryWord(event.name, event.categoryId);

      if (word is WordModel) {
        yield CategoryWordUpdateSuccess(message: 'Adaugat cu succes');
      } else {
        yield CategoryWordUpdateFailure(error: word);
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      // print("altceva");
      yield CategoryWordUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      // print(err.runtimeType);
      yield CategoryWordUpdateFailure(
          error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }

  Stream<FoodState> _mapDeleteCategoryWordToState(
      DeleteCategoryWord event) async* {
    yield CategoryWordLoading();

    try {
      final String? message = await _repository.deleteCategoryWord(event.slug);

      if (message != null) {
        yield DeleteCategoryWordSuccess(
            message: 'Cuvantul a fost sters cu succes');
      } else {
        yield DeleteCategoryWordFailure(error: 'Nu se poate sterge');
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      // print("altceva");
      yield CategoryWordUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      // print(err.runtimeType);
      yield CategoryWordUpdateFailure(
          error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }

  Stream<FoodState> _mapDeleteCategoryToState(DeleteCategory event) async* {
    yield CategoryWordLoading();

    try {
      final String? message = await _repository.deleteCategory(event.slug);

      if (message != null) {
        yield DeleteCategorySuccess(
            message: 'Categoria a fost stearsa cu succes');
      } else {
        yield DeleteCategoryFailure(error: 'Nu se poate sterge');
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      // print("altceva");
      yield CategoryWordUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      // print(err.runtimeType);
      yield CategoryWordUpdateFailure(
          error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }

  Stream<FoodState> _mapUpdateCategoryToState(UpdateCategory event) async* {
    yield CategoryWordLoading();

    try {
      final CategoryModel? category =
          await _repository.updateCategory(event.name, event.slug);

      if (category != null) {
        yield CategoryUpdateSuccess(
            message: 'Categoria updatata cu succes', category: category);
      } else {
        yield DeleteCategoryFailure(error: 'Nu se poate sterge');
      }

      yield CategoryInitial();
    } on AuthenticationException catch (e) {
      // print("altceva");
      yield CategoryWordUpdateFailure(error: e.message);
      yield CategoryInitial();
    } catch (err) {
      // print(err.runtimeType);
      yield CategoryWordUpdateFailure(
          error: 'An ${err.runtimeType} error occured');
      yield CategoryInitial();
    }
  }
}
