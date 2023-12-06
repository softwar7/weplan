import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:intl/intl.dart';

import 'package:weplan/viewmodels/schedule.dart';

class TimeTableComponent extends StatelessWidget {
  final List<TimetableItem> items;
  final void Function(TimetableItem) onTap;
  final int startHour;
  final int endHour;
  final TimetableController controller;

  TimeTableComponent({
    super.key,
    required this.items,
    required this.onTap,
    this.startHour = 9,
    this.endHour = 21,
  })  : assert(startHour < endHour),
        controller = TimetableController(
          timelineWidth: 70,
          initialColumns: 7,
          cellHeight: 60,
          startHour: startHour,
          endHour: endHour,
          start: DateTime.now().subtract(
            Duration(days: DateTime.now().weekday - 1),
          ), // Start on Monday
        );

  int colorTime(DateTime time) {
    DateTime now = DateTime.now();
    if (time.millisecondsSinceEpoch < now.millisecondsSinceEpoch)
      return Colors.grey[700]!.value;

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    int millisecondsDiff = time.millisecondsSinceEpoch -
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day)
            .millisecondsSinceEpoch;
    int hoursDiff = millisecondsDiff ~/ 1000 ~/ 60 ~/ 60;

    return const Color.fromARGB(255, 255, 255, 255).value -
        (hoursDiff * 1000000);
  }

  @override
  Widget build(BuildContext context) {
    return Timetable(
      controller: controller,
      nowIndicatorColor: Colors.red,
      headerCellBuilder: (datetime) {
        return Center(
          child: Text(
            DateFormat('MM/dd\nE', 'ko_KR').format(datetime),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
      cellBuilder: (datetime) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
        );
      },
      hourLabelBuilder: (time) => Text('${time.hour}시'),
      items: items,
      itemBuilder: (item) {
        ScheduleViewModel schedule = item.data as ScheduleViewModel;
        return GestureDetector(
          onTap: () => this.onTap(item),
          child: Container(
            decoration: BoxDecoration(
              color: Color(colorTime(item.start)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(schedule.name),
            ),
          ),
        );
      },
    );
  }
}
