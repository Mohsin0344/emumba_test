import 'package:emumba_test/data/events_repository.dart';
import 'package:emumba_test/view_models/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ViewModelExceptionHandler<T> on Cubit<T> {
  handleException(Object e) {
    if (e is CustomException) {
      emit(UnknownErrorState(error: e.message) as T);
    }
  }
}
