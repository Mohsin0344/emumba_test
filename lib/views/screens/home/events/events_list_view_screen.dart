import 'package:emumba_test/views/screens/home/events/events_list.dart';
import 'package:emumba_test/views/widgets/app_sliver_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<String> eventTypes = [
    'All',
    'Event',
    'Out of Office',
    'Task',
  ];

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {}

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
            child: Wrap(
              spacing: 10.h,
              children: List.generate(
                eventTypes.length,
                    (index) => DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r,),
                    color: AppColors.primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Text(
                      eventTypes[index],
                      style: AppFonts.bodyFont(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        EventsList(),
      ],
    );
  }
}
