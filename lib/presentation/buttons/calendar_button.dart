import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarButton extends StatelessWidget {
  const CalendarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                width: 300,
                height: 400,
                child: TableCalendar(
                  headerStyle: const HeaderStyle(formatButtonVisible: false),
                  locale: 'es_ES',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.calendar_month_outlined),
    );
  }
}
