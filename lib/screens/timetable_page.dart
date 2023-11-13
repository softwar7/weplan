import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:intl/intl.dart';

import 'package:weplan/components/timetable.dart';
import 'package:weplan/models/channel.dart';
import 'package:weplan/models/schedule.dart';

class TimeTable extends StatefulWidget {
  final Channel channel;

  const TimeTable({super.key, required this.channel});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();

    // context
    //     .read<ApiService>()
    //     .getSchedules(widget.channel)
    //     .then(
    //       (res) => setState(() {
    //         schedules = res;
    //       }),
    //     )
    //     .catchError((e) {
    //   showErrorSnackBar(context, '스케쥴을 불러오는 중 오류가 발생했습니다.');
    // throw e;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return TimeTableComponent(
      onTap: (item) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 400,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${item.data}', style: const TextStyle(fontSize: 30)),
                    const Padding(padding: EdgeInsets.all(10)),
                    Text(
                      '시작시간: ${DateFormat('MM-dd HH:mm').format(item.start)}',
                    ),
                    Text('종료시간: ${DateFormat('MM-dd HH:mm').format(item.end)}'),
                    Text('${(item.data)}'),
                  ],
                ),
              ),
            );
          },
        );
      },
      items: schedules
          .map(
            (e) => TimetableItem(
              e.start,
              e.end,
              data: e,
            ),
          )
          .toList(),
    );
  }
}
