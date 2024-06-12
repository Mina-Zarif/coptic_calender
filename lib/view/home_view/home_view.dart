import 'package:coptic_calender/data/data.dart';
import 'package:coptic_calender/data/model.dart';
import 'package:flutter/material.dart';

import '../../data/coptic_handler.dart';
import 'calendar_view.dart';

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({super.key});

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  DateTime gregorianDate = DateTime.now();
  late CopticDate copticDate, selectedDate;
  CopticHandler handler = CopticHandler();
  late List<List<int>> days;
  bool copticDays = false;

  @override
  void initState() {
    var data = handler.fromGregorian(
      gregorianDate.year,
      gregorianDate.month,
      gregorianDate.day,
    );
    copticDate = CopticDate.fromGregorian(data);
    selectedDate = CopticDate.fromGregorian(data);
    days = handler.monthCalendar(
      selectedDate.year!,
      selectedDate.month!,
    );
    super.initState();
  }

  void selectDay(CopticDate selected) {
    setState(() {
      selectedDate = selected;
      gregorianDate = handler.toGregorian(
        selected.year!,
        selected.month!,
        selected.day!,
      );
    });
  }

  void nextMonth() {
    setState(() {
      if (selectedDate.month == 13) {
        selectedDate = CopticDate(
          year: selectedDate.year! + 1,
          month: 1,
          day: 1,
        );
      } else {
        selectedDate = CopticDate(
          year: selectedDate.year,
          month: selectedDate.month! + 1,
          day: 1,
        );
      }
      gregorianDate = handler.toGregorian(
        selectedDate.year!,
        selectedDate.month!,
        selectedDate.day!,
      );
      days = handler.monthCalendar(
        selectedDate.year!,
        selectedDate.month!,
      );
    });
  }

  void prevMonth() {
    setState(() {
      if (selectedDate.month == 1) {
        selectedDate = CopticDate(
          year: selectedDate.year! - 1,
          month: 12,
          day: 1,
        );
      } else {
        selectedDate = CopticDate(
          year: selectedDate.year,
          month: selectedDate.month! - 1,
          day: 1,
        );
      }
      gregorianDate = handler.toGregorian(
        selectedDate.year!,
        selectedDate.month!,
        selectedDate.day!,
      );
      days = handler.monthCalendar(
        selectedDate.year!,
        selectedDate.month!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coptic Calendar'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => copticDays = !copticDays);
            },
            child: Text(
              (!copticDays) ? "Coptic Days" : "Gregorian Days",
              style: const TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          ),
          TextButton(
            onPressed: () => selectDay(copticDate),
            child: const Text(
              "Today",
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => prevMonth(),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Column(
                  children: [
                    Text(
                      handler.format(
                        selectedDate.year!,
                        selectedDate.month!,
                        selectedDate.day!,
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "${gregorianDate.day} ${gregorianMonths[gregorianDate.month - 1]} ${gregorianDate.year}"),
                  ],
                ),
                IconButton(
                  onPressed: () => nextMonth(),
                  icon: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            const SizedBox(height: 50),
            Expanded(
              child: CalendarView(
                copticDays: copticDays,
                data: days,
                selectedCopticDate: selectedDate,
                onTap: (day) => selectDay(day),
                todayCopticDate: copticDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
