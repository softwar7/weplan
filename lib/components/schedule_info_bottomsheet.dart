import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:weplan/components/delete_button.dart';
import 'package:weplan/components/modify_button.dart';
import 'package:weplan/screens/forms/schedule_form.dart';
import 'package:weplan/services/my_reservation_service.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ScheduleBottomSheet extends StatelessWidget {
  final ScheduleViewModel schedule;
  final void Function() handleRefresh;
  const ScheduleBottomSheet({
    super.key,
    required this.schedule,
    required this.handleRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(schedule.name, style: const TextStyle(fontSize: 30)),
            const Padding(padding: EdgeInsets.all(10)),
            Text('내용: ${schedule.content ?? '없음'}'),
            Text(
              '시작시간: ${DateFormat('MM-dd HH:mm').format(schedule.start)}',
            ),
            Text(
              '종료시간: ${DateFormat('MM-dd HH:mm').format(schedule.end)}',
            ),
            if (context.read<MyReservationsService>().map[schedule.id] != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ModifyButton(
                    alertDialog: ScheduleFormAlertDialog(
                      schedule: schedule,
                    ),
                  ),
                  DeleteButton(
                    title: '스케줄 삭제',
                    handleDelete: () async {
                      await schedule.deleteSchedule(
                        verbose: true,
                      );
                      handleRefresh();
                      // widget.channel.updateSchedules();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
