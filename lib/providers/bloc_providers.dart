import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/events_repository.dart';
import '../view_models/events/get_events_view_model.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<GetEventsViewModel>(
      create: (context) => GetEventsViewModel(
        EventRepository(),
      ),
    )
  ];
}
