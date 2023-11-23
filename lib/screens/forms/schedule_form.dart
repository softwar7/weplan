import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/viewmodels/channel.dart';

class ScheduleForm extends StatefulWidget {
  final ChannelViewModel channel;
  const ScheduleForm({super.key, required this.channel});

  @override
  State<ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  int? channelId;
  String name = '';
  String content = '';
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(hours: 1));

  @override
  void initState() {
    super.initState();
    this.channelId = widget.channel.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스케쥴 생성'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) => validate(value, Validator.name),
                onSaved: (value) => this.name = value!,
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
              ),
              TextFormField(
                // validator: (value) => validate(value, Validator.name),
                onSaved: (value) => this.content = value!,
                decoration: const InputDecoration(
                  labelText: '세부사항',
                ),
              ),
              DropdownButtonFormField(
                value: channelId,
                decoration: const InputDecoration(
                  labelText: '채널',
                ),
                items: context
                    .watch<ChannelService>()
                    .list
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null)
                    setState(() {
                      this.channelId = value;
                    });
                },
              ),
              Row(
                children: [
                  const Text('시작시간'),
                  TextButton(
                    child: Text(intl.DateFormat('MM-dd').format(start)),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: start,
                      ).then(
                        (value) => setState(() {
                          this.start = DateTime(
                            value?.year ?? start.year,
                            value?.month ?? start.month,
                            value?.day ?? start.day,
                            start.hour,
                            start.minute,
                          );
                        }),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(intl.DateFormat('HH:mm').format(start)),
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(start),
                      ).then(
                        (value) => setState(() {
                          this.start = DateTime(
                            start.year,
                            start.month,
                            start.day,
                            value?.hour ?? start.hour,
                            value?.minute ?? start.minute,
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
              Row(
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
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && channelId != null) {
                    _formKey.currentState!.save();
                    context
                        .read<ChannelService>()
                        .createSchedule(
                          channelId: channelId!,
                          name: this.name,
                          content: this.content,
                          start: this.start,
                          end: this.end,
                          verbose: true,
                        )
                        .then((value) {
                      Navigator.pop(context);
                      widget.channel.updateSchedules();
                    });
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
                child: const Text('스케줄 생성'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
