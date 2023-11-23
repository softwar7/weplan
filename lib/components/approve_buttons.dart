import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/enum/approval.dart';
import 'package:weplan/services/reservation_request_service.dart';
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
            // TODO: seperate updating logic from the component
            schedule.approve(Approval.REJECTED).then(
                  (value) => context.read<ReservationRequestService>().update(),
                );
          },
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            // FIXME: Bug when converting Approval Enum to String automatically
            // TODO: seperate updating logic from the component
            schedule.approve(Approval.APPROVED).then(
                  (value) => context.read<ReservationRequestService>().update(),
                );
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
