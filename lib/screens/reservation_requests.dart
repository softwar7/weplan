import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/approval_status.dart';
import 'package:weplan/components/approve_buttons.dart';
import 'package:weplan/services/reservation_request_service.dart';
import 'package:weplan/viewmodels/schedule.dart';

class ReservationRequests extends StatefulWidget {
  const ReservationRequests({super.key});

  @override
  State<ReservationRequests> createState() => _ReservationRequestsState();
}

class _ReservationRequestsState extends State<ReservationRequests> {
  Future<void> handleRefresh() async {
    context.read<ReservationRequestService>().update();
  }

  @override
  void initState() {
    super.initState();
    handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    List<ScheduleViewModel> items =
        context.watch<ReservationRequestService>().list;
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: handleRefresh,
        child: items.isEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: const Center(child: Text('예약 요청이 없습니다.')),
                ),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    title: Text(items[index].name),
                    subtitle: Text(items[index].startToEnd),
                    leading: ApprovalStatus(
                      approval: items[index].approval,
                    ),
                    trailing: ApproveButtons(schedule: items[index]),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(items[index].name),
                          content: Text(
                            '시작: ${items[index].start.toLocal()}\n종료: ${items[index].end.toLocal()}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, thickness: 0.1),
                itemCount: items.length,
              ),
      ),
    );
  }
}
