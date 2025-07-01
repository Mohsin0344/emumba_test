import 'package:flutter/material.dart';
import '../../../widgets/app_sliver_bar.dart';
import '../../../widgets/calendar_widget.dart';
import 'events_list.dart';

class EventsCalendarScreen extends StatefulWidget {
  const EventsCalendarScreen({super.key});

  @override
  State<EventsCalendarScreen> createState() => _EventsCalendarScreenState();
}

class _EventsCalendarScreenState extends State<EventsCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const AppSliverBar(),
        CalendarWidget(
          onDateChange: (selectedDate) {
            print(selectedDate);
          },
        ),
        const EventsList(),
      ],
    );
  }
}
