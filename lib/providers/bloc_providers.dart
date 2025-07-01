import 'package:emumba_test/view_models/events/delete_event_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/events_repository.dart';
import '../view_models/events/create_event_view_model.dart';
import '../view_models/events/get_events_view_model.dart';
import '../view_models/events/update_event_view_model.dart';
import '../view_models/nav_bar/nav_bar_view_model.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<GetEventsViewModel>(
      create: (context) => GetEventsViewModel(
        EventRepository(),
      ),
    ),
    BlocProvider<NavBarViewModel>(
      create: (context) => NavBarViewModel(),
    ),
    BlocProvider<CreateEventViewModel>(
      create: (context) => CreateEventViewModel(
        EventRepository(),
      ),
    ),
    BlocProvider<DeleteEventViewModel>(
      create: (context) => DeleteEventViewModel(
        EventRepository(),
      ),
    ),
    BlocProvider<UpdateEventViewModel>(
      create: (context) => UpdateEventViewModel(
        EventRepository(),
      ),
    )
  ];
}
