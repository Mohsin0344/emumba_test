import 'package:emumba_test/view_models/events/get_events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetEventsViewModel getEventsViewModel;


  @override
  void initState() {
    super.initState();
    initViewModels();
    callViewModels();
  }

  initViewModels() {
    getEventsViewModel = context.read<GetEventsViewModel>();
  }

  callViewModels() {
   getEventsViewModel.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events',
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white38
              ),
              child: Column(
                children: [
                  eventHeader(heading: 'Name', value: 'value'),
                  eventHeader(heading: 'Description', value: 'value'),
                  eventHeader(heading: 'Date/Time', value: 'value'),
                  eventHeader(heading: 'Event Type', value: 'value'),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return 10.verticalSpace;
        },
        itemCount: 10,
      ),
    );
  }

  eventHeader({required String heading, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
        ),
        Text(
            value,
        ),
      ],
    );
  }
}
