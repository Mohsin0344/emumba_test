import 'package:bloc/bloc.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class DeleteEventViewModel extends Cubit<AppState> {
  final EventRepository _eventRepository;

  DeleteEventViewModel(this._eventRepository) : super(const InitialState());

  deleteEvent({
    required int eventId,
  }) async {
    try {
      emit(const LoadingState());
      final event = await _eventRepository.deleteEvent(
        eventId,
      );
      emit(
        SuccessState(
          data: event,
        ),
      );
    } catch (e) {
      emit(
        UnknownErrorState(
          error: e.toString(),
        ),
      );
    }
  }
}
