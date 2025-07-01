import 'package:emumba_test/utils/app_extension_methods.dart';
import 'package:emumba_test/utils/app_fonts.dart';
import 'package:emumba_test/view_models/events/delete_event_view_model.dart';
import 'package:emumba_test/views/widgets/views_exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app_routes/app_route_model/manage_event_route_model.dart';
import '../../../../app_routes/route_names.dart';
import '../../../../models/model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../view_models/app_states.dart';
import '../../../../view_models/events/get_events_view_model.dart';
import '../../../widgets/app_loading_indicator.dart';
import 'delete_event_dialog.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late GetEventsViewModel getEventsViewModel;
  late DeleteEventViewModel deleteEventViewModel;

  @override
  void initState() {
    super.initState();
    initViewModels();
    callViewModels();
  }

  initViewModels() {
    getEventsViewModel = context.read<GetEventsViewModel>();
    deleteEventViewModel = context.read<DeleteEventViewModel>();
  }

  callViewModels() {
    getEventsViewModel.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      sliver: MultiBlocListener(
        listeners: [
          BlocListener<DeleteEventViewModel, AppState>(
            listener: (context, deleteState) {
              if (deleteState is SuccessState) {
                getEventsViewModel.getEvents();
              }
              errorHandler(context: context, state: deleteState);
            },
          ),
          BlocListener<GetEventsViewModel, AppState>(
            listener: (context, eventsState) {
              errorHandler(context: context, state: eventsState);
            },
          )
        ],
        child: BlocBuilder<GetEventsViewModel, AppState>(
          builder: (context, eventsState) {
            if (eventsState is SuccessState<List<Event>>) {
              List<Event> events = eventsState.data;
              if (events.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No Events found',
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  events[index].name ?? '',
                                  style: AppFonts.bodyFont(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final isDelete =
                                      await showDeleteEventDialog(context);
                                  if (isDelete ?? false) {
                                    deleteEventViewModel.deleteEvent(
                                      eventId: events[index].id!,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.redColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.manageEventScreen,
                                    arguments: ManageEventRouteModel(
                                      event: events[index],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            events[index].dateTime?.toReadableDateTime() ?? '',
                            style: AppFonts.bodyFont(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            events[index].description ?? '',
                            style: AppFonts.bodyFont(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            events[index].type ?? '',
                            style: AppFonts.bodyFont(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          if (events[index].attachment != null)
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.file_copy,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          15.verticalSpace,
                        ],
                      ),
                    );
                  },
                  childCount: events.length,
                ),
              );
            }
            return const SliverToBoxAdapter(
              child: AppLoadingIndicator(
                color: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
