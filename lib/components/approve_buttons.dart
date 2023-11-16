import 'package:flutter/material.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ApproveButtons extends StatelessWidget {
  final ScheduleViewModel schedule;

  const ApproveButtons({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        IconButton(
          onPressed: () {
            // FIXME: Bug when converting Approval Enum to String automatically
            schedule.approve(Approval.REJECTED);
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            // FIXME: Bug when converting Approval Enum to String automatically
            schedule.approve(Approval.APPROVED);
          },
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
