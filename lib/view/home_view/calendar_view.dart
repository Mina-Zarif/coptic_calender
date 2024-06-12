import 'package:coptic_calender/data/data.dart';
import 'package:flutter/material.dart';

import '../../data/coptic_handler.dart';
import '../../data/model.dart';
import 'calendar_day_tile.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({
    super.key,
    required this.todayCopticDate,
    required this.onTap,
    required this.selectedCopticDate,
    required this.data,
    required this.copticDays,
  });

  final CopticDate todayCopticDate;
  final bool copticDays;
  final CopticDate selectedCopticDate;
  final Function(CopticDate selectedDate) onTap;
  final List<List<int>> data;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  final CopticHandler handler = CopticHandler();

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (index) => SizedBox(
              width: 50,
              height: 50,
              child: Text(
                (widget.copticDays) ? copticDays[index] : days[index],
                style: TextStyle(
                  color: (index == 5 || index == 6)
                      ? Colors.red.shade400
                      : Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        for (var row = 0; row < widget.data.length; row++)
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < widget.data[row].length; index++)
                CalendarDayTile(
                  today: widget.todayCopticDate,
                  dayNumber: widget.data[row][index],
                  selectedDate: widget.selectedCopticDate,
                  onTap: () => widget.onTap(
                    CopticDate(
                      year: widget.selectedCopticDate.year,
                      month: widget.selectedCopticDate.month,
                      day: widget.data[row][index],
                    ),
                  ),
                )
            ],
          )
      ],
    );
  }
}
