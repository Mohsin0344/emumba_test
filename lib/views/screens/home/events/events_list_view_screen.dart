import 'package:emumba_test/views/screens/home/events/events_list.dart';
import 'package:emumba_test/views/widgets/app_sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../view_models/events/get_events_view_model.dart';
import 'event_types_chip.dart';

class EventsListViewScreen extends StatefulWidget {
  const EventsListViewScreen({super.key});

  @override
  State<EventsListViewScreen> createState() => _EventsListViewScreenState();
}

class _EventsListViewScreenState extends State<EventsListViewScreen> {
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
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          sliver: SliverToBoxAdapter(
            child: EventTypesChip(
              onEventSelected: (selectedEvent) {
                setState(() {
                  getEventsViewModel.selectedEventType =
                      selectedEvent == 'All' ? null : selectedEvent;
                  getEventsViewModel.getEvents();
                });
              },
              selectedType: getEventsViewModel.selectedEventType ?? 'All',
              showAllType: true,
            ),
          ),
        ),
        const EventsList(),
      ],
    );
  }
}
