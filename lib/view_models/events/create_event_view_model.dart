import 'package:bloc/bloc.dart';
import 'package:emumba_test/view_models/view_model_exception_handler.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class CreateEventViewModel extends Cubit<AppState> with ViewModelExceptionHandler {
  final EventRepository _eventRepository;

  CreateEventViewModel(this._eventRepository) : super(const InitialState());

  createEvent({
    required String name,
    String? description,
    required String type,
    required DateTime createdAt,
  }) async {
    try {
      emit(const LoadingState());
      await _eventRepository.createEvent(
        name: name,
        description: description,
        type: type,
        dateTime: createdAt,
      );
      emit(
        const SuccessState(
          data: 'Event created Successfully',
        ),
      );
    } catch (e) {
      handleException(e);
    }
  }
}
