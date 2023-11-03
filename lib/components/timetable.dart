import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';

class TimeTableComponent extends StatelessWidget {
  final List<TimetableItem> items;
  final void Function(TimetableItem) onTap;
  TimeTableComponent({
    super.key,
    required this.items,
    required this.onTap,
  });

  final controller = TimetableController(
    timelineWidth: 70,
    initialColumns: 7,
    cellHeight: 60,
    startHour: 9,
    endHour: 21,
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
      cellBuilder: (datetime) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
        );
      },
      hourLabelBuilder: (time) => Text('${time.hour}시'),
      items: items,
      itemBuilder: (item) => GestureDetector(
        onTap: () {
          this.onTap(item);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(colorTime(item.start)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              item.data ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
