import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../view_models/events/get_events_view_model.dart';
import '../../../widgets/app_sliver_bar.dart';
import '../../../widgets/calendar_widget.dart';
import 'events_list.dart';

class EventsCalendarScreen extends StatefulWidget {
  const EventsCalendarScreen({super.key});

  @override
  State<EventsCalendarScreen> createState() => _EventsCalendarScreenState();
}

class _EventsCalendarScreenState extends State<EventsCalendarScreen> {
  late GetEventsViewModel getEventsViewModel;

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {
    getEventsViewModel = context.read<GetEventsViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const AppSliverBar(),
        CalendarWidget(
          onDateChange: (selectedDate) {
            getEventsViewModel.selectedDateTime = selectedDate.value;
            getEventsViewModel.getEvents();
          },
        ),
        const EventsList(),
      ],
    );
  }
}
