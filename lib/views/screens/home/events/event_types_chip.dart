import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';

class EventTypesChip extends StatefulWidget {
  final String? selectedType;
  final ValueChanged<String> onEventSelected;
  final bool showAllType;

  const EventTypesChip({
    super.key,
    required this.onEventSelected,
    this.selectedType,
    required this.showAllType,
  });

  @override
  State<EventTypesChip> createState() => _EventTypesChipState();
}

class _EventTypesChipState extends State<EventTypesChip> {
  List<String> eventTypes = [
    'Event',
    'Out of Office',
    'Task',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.h,
      children: [
        if (widget.showAllType)
          eventTypeChip(
            isSelected: widget.selectedType == 'All',
            eventType: 'All',
            onTap: () {
              widget.onEventSelected('All');
            },
          ),
        ...List.generate(
          eventTypes.length,
          (index) => eventTypeChip(
            eventType: eventTypes[index],
            isSelected: widget.selectedType == eventTypes[index],
            onTap: () {
              widget.onEventSelected(
                eventTypes[index],
              );
            },
          ),
        )
      ],
    );
  }

  Widget eventTypeChip({
    required Function() onTap,
    required bool isSelected,
    required String eventType,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          color: isSelected ? AppColors.primaryColor : AppColors.disabledColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 6.h,
          ),
          child: Text(
            eventType,
            style: AppFonts.bodyFont(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
