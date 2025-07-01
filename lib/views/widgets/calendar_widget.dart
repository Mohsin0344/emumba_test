import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';

class CalendarWidget extends StatefulWidget {
  final ValueChanged<DateRangePickerSelectionChangedArgs> onDateChange;

  const CalendarWidget({
    super.key,
    required this.onDateChange,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SfDateRangePicker(
        controller: _datePickerController,
        backgroundColor: AppColors.secondaryColor,
        headerStyle: DateRangePickerHeaderStyle(
          backgroundColor: AppColors.secondaryColor,
          textAlign: TextAlign.center,
          textStyle: AppFonts.bodyFont(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.blackColor,
          ),
        ),
        selectionMode: DateRangePickerSelectionMode.single,
        view: DateRangePickerView.month,
        onSelectionChanged: _onSelectionChanged,
        monthCellStyle: DateRangePickerMonthCellStyle(
          todayTextStyle: AppFonts.bodyFont(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackColor,
          ),
          disabledDatesTextStyle: AppFonts.bodyFont(
            color: AppColors.blackColor,
          ),
          textStyle: AppFonts.bodyFont(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackColor,
          ),
          rangeTextStyle: AppFonts.bodyFont(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: AppColors.blackColor,
          ),
          todayCellDecoration: const BoxDecoration(),
        ),
        rangeTextStyle: AppFonts.bodyFont(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColors.blackColor,
        ),
        selectionShape: DateRangePickerSelectionShape.rectangle,
        selectionColor: AppColors.primaryColor,
        startRangeSelectionColor: AppColors.primaryColor,
        endRangeSelectionColor: AppColors.primaryColor,
        // rangeSelectionColor: AppColors.lightCalendar,
        selectionRadius: 8,
        minDate: DateTime.now(),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    widget.onDateChange(args);
  }
}
