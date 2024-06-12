import 'package:flutter/material.dart';

import '../../data/model.dart';

class CalendarDayTile extends StatelessWidget {
  final int dayNumber;
  final CopticDate selectedDate;
  final CopticDate today;
  final Function() onTap;

  const CalendarDayTile({
    super.key,
    required this.dayNumber,
    required this.selectedDate,
    required this.onTap,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    return (dayNumber != 0)
        ? InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: (today.day == dayNumber &&
                            selectedDate.month == today.month &&
                            selectedDate.year == today.year)
                        ? Colors.blue
                        : Colors.transparent,
                  ),
                ),
                color: (selectedDate.day == dayNumber)
                    ? Colors.blue
                    : Colors.transparent,
                child: Center(
                  child: Text('$dayNumber'),
                ),
              ),
            ),
          )
        : const SizedBox(
            width: 50,
            height: 50,
          );
  }
}
