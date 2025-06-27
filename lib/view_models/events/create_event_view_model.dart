import 'package:bloc/bloc.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class CreateEventViewModel extends Cubit<AppState> {
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
      final event = await _eventRepository.createEvent(
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
