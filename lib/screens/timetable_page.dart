import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_timetable/flutter_timetable.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/schedule_info_bottomsheet.dart';
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
  Timer? timer;
  @override
  void initState() {
    super.initState();
    widget.channel.updateSchedules();
    timer = Timer.periodic(
      const Duration(seconds: 15),
      (Timer t) => widget.channel.updateSchedules(verbose: false),
    );
  }

  @override
  void didUpdateWidget(covariant TimeTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.channel.updateSchedules();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
              return ScheduleBottomSheet(
                schedule: schedule,
                handleRefresh: widget.channel.updateSchedules,
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
