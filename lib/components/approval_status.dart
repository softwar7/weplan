import 'package:flutter/material.dart';

import 'package:weplan/models/enum/approval.dart';

class ApprovalStatus extends StatelessWidget {
  final Approval approval;
  List<Widget> get children {
    if (approval == Approval.PENDING)
      return const [
        Icon(Icons.pending_actions_outlined, color: Colors.blue),
        Text('대기중'),
      ];
    else if (approval == Approval.APPROVED)
      return const [
        Icon(
          Icons.check,
          color: Colors.green,
        ),
        Text('승인됨'),
      ];
    else if (approval == Approval.REJECTED)
      return const [Icon(Icons.close, color: Colors.red), Text('거절됨')];
    else
      throw Exception('ApprovalStatus: Invalid Approval');
  }

  const ApprovalStatus({super.key, required this.approval});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
