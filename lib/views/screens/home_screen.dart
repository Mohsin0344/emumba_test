import 'package:emumba_test/view_models/events/get_events_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/model.dart';
import '../../view_models/app_states.dart';

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
          title: const Text(
            'Events',
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GetEventsViewModel, AppState>(
          builder: (context, state) {
            if (state is SuccessState<List<Event>>) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                itemBuilder: (context, index) {
                  Event event = state.data[index];
                  return SizedBox(
                    height: 100.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white38),
                      child: Column(
                        children: [
                          eventHeader(
                            heading: 'Name',
                            value: event.name ?? '',
                          ),
                          eventHeader(
                            heading: 'Description',
                            value: event.description ?? '',
                          ),
                          eventHeader(
                            heading: 'Date/Time',
                            value: event.dateTime.toString(),
                          ),
                          eventHeader(
                            heading: 'Event Type',
                            value: event.type ?? '',
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return 10.verticalSpace;
                },
                itemCount: state.data.length,
              );
            }
            return Container();
          },
        ));
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
