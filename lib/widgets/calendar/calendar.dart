import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/app_colors.dart';
import 'package:ezhandy_user/widgets/Container/custom_container.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime> highlightedDates;
  final Function(DateTime selectedDate)? onDateSelected;
  final DateTime? initialFocusedDate;
  final DateTime? selectedDate;

  const CustomCalendar({
    Key? key,
    required this.highlightedDates,
    this.onDateSelected,
    this.initialFocusedDate,
    this.selectedDate,
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
    _applyInitialSelection();
  }

  @override
  void didUpdateWidget(CustomCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.highlightedDates != widget.highlightedDates ||
        oldWidget.initialFocusedDate != widget.initialFocusedDate ||
        !_isSameCalendarDay(oldWidget.selectedDate, widget.selectedDate)) {
      _applyInitialSelection();
    }
  }

  void _applyInitialSelection() {
    final available = widget.highlightedDates.map(_dateOnlyLocal).toList();
    if (available.isNotEmpty) {
      final initial = widget.selectedDate != null
          ? _dateOnlyLocal(widget.selectedDate!)
          : (widget.initialFocusedDate != null
              ? _dateOnlyLocal(widget.initialFocusedDate!)
              : available.first);
      focusedDay = initial;
      selectedDay = available.firstWhere(
        (d) => _isSameCalendarDay(d, initial),
        orElse: () => available.first,
      );
    } else {
      focusedDay = _dateOnlyLocal(
        widget.initialFocusedDate ?? DateTime.now(),
      );
      selectedDay = widget.selectedDate != null
          ? _dateOnlyLocal(widget.selectedDate!)
          : null;
    }
  }

  /// Normalizes to local calendar date (fixes UTC vs local mismatch from TableCalendar).
  static DateTime _dateOnlyLocal(DateTime d) {
    final local = d.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  static bool _isSameCalendarDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return a == b;
    final da = _dateOnlyLocal(a);
    final db = _dateOnlyLocal(b);
    return da.year == db.year && da.month == db.month && da.day == db.day;
  }

  bool _isTodayOrFuture(DateTime day) {
    final today = _dateOnlyLocal(DateTime.now());
    return !_dateOnlyLocal(day).isBefore(today);
  }

  bool isAvailable(DateTime day) {
    if (!_isTodayOrFuture(day)) return false;
    return widget.highlightedDates
        .any((d) => _isSameCalendarDay(d, day));
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: focusedDay,
      enabledDayPredicate: isAvailable,
      selectedDayPredicate: (day) =>
          selectedDay != null && _isSameCalendarDay(selectedDay, day),
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
        defaultBuilder: (context, day, _) => _dayCell(day),
        outsideBuilder: (context, day, _) => _dayCell(day, isOutside: true),
        disabledBuilder: (context, day, _) => _dayCell(day, isDisabled: true),
      ),
      onDaySelected: (selected, focused) {
        if (!isAvailable(selected)) return;
        final day = _dateOnlyLocal(selected);
        setState(() {
          selectedDay = day;
          focusedDay = _dateOnlyLocal(focused);
        });
        widget.onDateSelected?.call(day);
      },
    );
  }

  Widget _dayCell(DateTime day, {bool isOutside = false, bool isDisabled = false}) {
    final available = isAvailable(day);
    final selected =
        selectedDay != null && _isSameCalendarDay(selectedDay, day);
    final enabled = available && !isDisabled;

    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      width: 43.w,
      height: 35.h,
      alignment: Alignment.center,
      decoration: enabled
          ? BoxDecoration(
              color: selected
                  ? AppColors.orange
                  : AppColors.orange.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(10.r),
            )
          : null,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: enabled
              ? Colors.white
              : (isOutside ? AppColors.red : AppColors.greyLight),
          fontWeight: enabled ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }
}
