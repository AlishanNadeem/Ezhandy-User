import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime> highlightedDates;
  final Function(DateTime selectedDate)? onDateSelected;
  final DateTime? initialFocusedDate;

  const CustomCalendar({
    Key? key,
    required this.highlightedDates,
    this.onDateSelected,
    this.initialFocusedDate,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime? selectedDay;
  late DateTime focusedDay;

  @override
  void initState() {
    super.initState();
    focusedDay = widget.initialFocusedDate ?? DateTime.now();
    selectedDay = widget.highlightedDates[0];
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool isHighlighted(DateTime day) {
    return widget.highlightedDates.any((d) => isSameDay(d, day));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) =>
          isSameDay(selectedDay ?? DateTime.now(), day),
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
        ),
        rightChevronMargin: EdgeInsets.zero,
        leftChevronMargin: EdgeInsets.zero,
        leftChevronIcon: CustomContainer(
            isPadding: false,
            borderColor: AppColors.orange,
            child: Icon(
              Icons.chevron_left,
              color: AppColors.orange,
              size: 30.sp,
            )),
        rightChevronIcon: CustomContainer(
            isPadding: false,
            borderColor: AppColors.orange,
            child: Icon(
              Icons.chevron_right,
              color: AppColors.orange,
              size: 30.sp,
            )),
      ),
      calendarStyle: CalendarStyle(
        outsideTextStyle: TextStyle(color: AppColors.greyLight),
        defaultTextStyle: TextStyle(color: Colors.black),
        weekendTextStyle: TextStyle(color: Colors.black),
        todayDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        selectedDecoration: BoxDecoration(
            color: AppColors.orange,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10.r)),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) {
          bool highlighted = isHighlighted(day);
          return Container(
            margin: EdgeInsets.only(bottom: 5.h),
            width: 43.w,
            height: 35.h,
            alignment: Alignment.center,
            decoration: highlighted
                ? BoxDecoration(
                    color: isSameDay(selectedDay!, day)
                        ? AppColors.orange
                        : AppColors.orange.withOpacity(0.7),
                    // : Colors.deepPurple.withOpacity(0.7),
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(10.r))
                : null,
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: highlighted ? Colors.white : Colors.black,
              ),
            ),
          );
        },
        outsideBuilder: (context, day, _) {
          return Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(color: AppColors.red),
            ),
          );
        },
      ),
      onDaySelected: (selected, focused) {
        if (isHighlighted(selected)) {
          setState(() {
            selectedDay = selected;
            focusedDay = focused;
          });

          if (widget.onDateSelected != null) {
            widget.onDateSelected!(selected);
          }
        }
      },
    );
  }
}
