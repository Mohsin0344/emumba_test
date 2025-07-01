import 'package:emumba_test/views/widgets/app_sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../view_models/events/get_events_view_model.dart';

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

  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AppSliverBar(),
      ],
    );
  }
}
