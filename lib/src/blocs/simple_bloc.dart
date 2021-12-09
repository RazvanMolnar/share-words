import 'package:bloc/bloc.dart';
import 'package:filip/src/api/repository.dart';
import 'simple_event.dart';
import 'simple_state.dart';

class SimpleInformationBloc extends Bloc<SimpleEvent, SimpleState> {
  final Repository _repository;

  SimpleInformationBloc(Repository repository)
      : _repository = repository,
        super(SimpleInformationInitial(years: 0, months: 0));

  @override
  Stream<SimpleState> mapEventToState(SimpleEvent event) async* {
    if (event is SimpleInformation) {
      yield* _mapAddCategoryToState(event);
    }
  }

  Stream<SimpleState> _mapAddCategoryToState(SimpleInformation event) async* {
    yield SimpleInformationLoading();

    try {
      yield SimpleInformationInitial(
          years: event.differenceInYears, months: event.differenceInMonths);
    } catch (err) {
      print(err.runtimeType);
      yield SimpleInformationInitial(years: 0, months: 0);
    }
  }
}
