import 'package:emumba_test/views/widgets/app_snack_bar.dart';
import 'package:emumba_test/views/widgets/views_exception_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../view_models/app_states.dart';
import '../../../../view_models/events/create_event_view_model.dart';
import '../../../../view_models/events/get_events_view_model.dart';
import '../../../../view_models/events/update_event_view_model.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_loading_indicator.dart';
import 'event_types_chip.dart';

class ManageEventScreen extends StatefulWidget {
  final Event? event;

  const ManageEventScreen({
    super.key,
    this.event,
  });

  @override
  State<ManageEventScreen> createState() => _ManageEventScreenState();
}

class _ManageEventScreenState extends State<ManageEventScreen> {
  late CreateEventViewModel createEventViewModel;
  late GetEventsViewModel getEventsViewModel;
  late UpdateEventViewModel updateEventViewModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDateTime;
  String? selectedEventType;

  @override
  void initState() {
    super.initState();
    initViewModel();
    populateEventDetails();
  }

  initViewModel() {
    createEventViewModel = context.read<CreateEventViewModel>();
    getEventsViewModel = context.read<GetEventsViewModel>();
    updateEventViewModel = context.read<UpdateEventViewModel>();
  }

  populateEventDetails() {
    if (widget.event != null) {
      Event event = widget.event!;
      nameController.text = event.name ?? '';
      descriptionController.text = event.description ?? '';
      selectedEventType = event.type;
      selectedDateTime = event.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateEventViewModel, AppState>(
          listener: (context, eventState) {
            if (eventState is SuccessState) {
              getEventsViewModel.getEvents();
              Navigator.pop(context);
            }
            errorHandler(context: context, state: eventState);
          },
        ),
        BlocListener<UpdateEventViewModel, AppState>(
          listener: (context, updateState) {
            if (updateState is SuccessState) {
              getEventsViewModel.getEvents();
              Navigator.pop(context);
            }
            errorHandler(context: context, state: updateState);
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            '${widget.event == null ? 'Create' : 'Update'} Event',
            style: AppFonts.bodyFont(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 30.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Event name'),
                      validator: (val) {
                        if (val?.isEmpty ?? false) {
                          return 'Event name can not be empty';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(hintText: 'Description...'),
                    ),
                    16.verticalSpace,
                    GestureDetector(
                      onTap: _selectDateTime,
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Select Date & Time',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (selectedDateTime == null) {
                              return 'Please select date and time';
                            }
                            return null;
                          },
                          controller: TextEditingController(
                            text: selectedDateTime == null
                                ? ''
                                : '${selectedDateTime!.toLocal()}'
                                    .split('.')
                                    .first,
                          ),
                        ),
                      ),
                    ),
                    16.verticalSpace,
                    Text(
                      'Select Event Type',
                      style: AppFonts.bodyFont(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    16.verticalSpace,
                    EventTypesChip(
                      showAllType: false,
                      onEventSelected: (selectedEvent) {
                        setState(() {
                          selectedEventType = selectedEvent;
                        });
                      },
                      selectedType: selectedEventType,
                    ),
                    16.verticalSpace,
                    Align(
                      alignment: Alignment.center,
                      child: BlocBuilder<CreateEventViewModel, AppState>(
                        builder: (context, eventState) {
                          if (eventState is LoadingState) {
                            return AppElevatedButton(
                              widget: const Center(
                                child: AppLoadingIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              onTap: () {},
                            );
                          }
                          return AppElevatedButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              if (!_formKey.currentState!.validate()) return;

                              if (selectedEventType == null) {
                                showCustomSnackBar(
                                    context, 'Select event type');
                                return;
                              }

                              final name = nameController.text.trim();
                              final description =
                                  descriptionController.text.trim();
                              final dateTime = selectedDateTime!;

                              if (widget.event != null) {
                                updateEventViewModel.updateEvent(
                                  eventId: widget.event!.id!,
                                  name: name,
                                  type: selectedEventType!,
                                  dateTime: dateTime,
                                );
                              } else {
                                createEventViewModel.createEvent(
                                  name: name,
                                  type: selectedEventType!,
                                  description: description,
                                  createdAt: dateTime,
                                );
                              }
                            },
                            widget: Text(
                              '${widget.event == null ? 'Create' : 'Update'} Event',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    FocusManager.instance.primaryFocus?.unfocus();
    DateTime now = DateTime.now();

    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );

    if (time == null) return;

    final DateTime combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (combined.isBefore(now)) {
      showCustomSnackBar(
        context,
        'Past DateTime not allowed',
      );
      return;
    }

    setState(() {
      selectedDateTime = combined;
    });
  }
}
