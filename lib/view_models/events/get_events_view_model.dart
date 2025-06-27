import 'package:bloc/bloc.dart';

import '../../data/events_repository.dart';
import '../app_states.dart';

class GetEventsViewModel extends Cubit<AppState> {
  final EventRepository _eventRepository;

  GetEventsViewModel(this._eventRepository) : super(const InitialState());

  getEvents() async {
    try {
      emit(const LoadingState());
      final events = await _eventRepository.getEvents();
      emit(
        SuccessState(
          data: events,
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
