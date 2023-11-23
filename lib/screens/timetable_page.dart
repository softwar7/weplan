import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/components/timetable.dart';
import 'package:weplan/viewmodels/channel.dart';
import 'package:weplan/viewmodels/schedule.dart';

class TimeTable extends StatefulWidget {
  final ChannelViewModel channel;

  const TimeTable({super.key, required this.channel});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  void initState() {
    super.initState();

    widget.channel.updateSchedules().catchError((e) {
      showErrorSnackBar(context, '스케쥴을 불러오는 중 오류가 발생했습니다.');
      throw e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.channel,
      builder: (context, child) => TimeTableComponent(
        onTap: (item) {
          ScheduleViewModel schedule = item.data as ScheduleViewModel;
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
                      Text(schedule.name, style: const TextStyle(fontSize: 30)),
                      const Padding(padding: EdgeInsets.all(10)),
                      Text('내용: ${schedule.content}'),
                      Text(
                        '시작시간: ${DateFormat('MM-dd HH:mm').format(schedule.start)}',
                      ),
                      Text(
                        '종료시간: ${DateFormat('MM-dd HH:mm').format(schedule.end)}',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        items: context
            .watch<ChannelViewModel>()
            .schedules
            .values
            .map(
              (e) => TimetableItem(
                e.start,
                e.end,
                data: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
