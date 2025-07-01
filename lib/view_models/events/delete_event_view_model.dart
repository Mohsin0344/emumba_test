import 'package:bloc/bloc.dart';
import 'package:emumba_test/view_models/view_model_exception_handler.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class DeleteEventViewModel extends Cubit<AppState>
    with ViewModelExceptionHandler {
  final EventRepository _eventRepository;

  DeleteEventViewModel(this._eventRepository) : super(const InitialState());

  deleteEvent({
    required int eventId,
  }) async {
    try {
      emit(const LoadingState());
      await _eventRepository.deleteEvent(
        eventId,
      );
      emit(
        const SuccessState(
          data: 'Event Deleted',
        ),
      );
    } catch (e) {
      handleException(e);
    }
  }
}
