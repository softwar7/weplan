import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/approval_status.dart';
import 'package:weplan/services/my_reservation_service.dart';
import 'package:weplan/viewmodels/schedule.dart';

class MyReservations extends StatefulWidget {
  const MyReservations({super.key});

  @override
  State<MyReservations> createState() => _MyReservationsState();
}

class _MyReservationsState extends State<MyReservations> {
  @override
  void initState() {
    super.initState();
    this.handleRefresh();
  }

  Future<void> handleRefresh() async {
    context.read<MyReservationsService>().update();
  }

  @override
  Widget build(BuildContext context) {
    List<ScheduleViewModel> items = context.watch<MyReservationsService>().list;
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 0.1),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Text(items[index].name),
            subtitle: Text(items[index].startToEnd),
            leading: ApprovalStatus(approval: items[index].approval),
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
      ),
    );
  }
}
