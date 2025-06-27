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
    required DateTime createdAt,
  }) async {
    try {
      emit(const LoadingState());
      final event = await _eventRepository.updateEvent(
        id: eventId,
        name: name,
        description: description,
        type: type,
        dateTime: createdAt,
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
