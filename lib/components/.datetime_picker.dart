import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('종료시간'),
        TextButton(
          child: Text(intl.DateFormat('MM-dd').format(end)),
          onPressed: () {
            showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              initialDate: end,
            ).then(
              (value) => setState(() {
                this.end = DateTime(
                  value?.year ?? end.year,
                  value?.month ?? end.month,
                  value?.day ?? end.day,
                  end.hour,
                  end.minute,
                );
              }),
            );
          },
        ),
        TextButton(
          child: Text(intl.DateFormat('HH:mm').format(end)),
          onPressed: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(end),
            ).then(
              (value) => setState(() {
                this.end = DateTime(
                  end.year,
                  end.month,
                  end.day,
                  value?.hour ?? end.hour,
                  value?.minute ?? end.minute,
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
