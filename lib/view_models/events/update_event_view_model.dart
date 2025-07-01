import 'package:bloc/bloc.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class UpdateEventViewModel extends Cubit<AppState> {
  final EventRepository _eventRepository;

  UpdateEventViewModel(this._eventRepository) : super(const InitialState());

  updateEvent({
    required int eventId,
    required String name,
    String? description,
    required String type,
    required DateTime dateTime,
  }) async {
    try {
      emit(const LoadingState());
      await _eventRepository.updateEvent(
        id: eventId,
        name: name,
        description: description,
        type: type,
        dateTime: dateTime,
      );
      emit(
        const SuccessState(
          data: 'Event updated successfully',
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
