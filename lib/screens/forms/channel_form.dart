import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/channel_service.dart';
import 'package:weplan/viewmodels/channel.dart';

class ChannelFormScaffold extends StatefulWidget {
  const ChannelFormScaffold({super.key});

  @override
  State<ChannelFormScaffold> createState() => _ChannelFormScaffoldState();
}

class _ChannelFormScaffoldState extends State<ChannelFormScaffold> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String name = '';
  String place = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채널 생성'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                validator: (value) => validate(value, Validator.name),
                onSaved: (value) => this.name = value!,
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
              ),
              TextFormField(
                validator: (value) => validate(value, Validator.name),
                onSaved: (value) => this.place = value!,
                decoration: const InputDecoration(
                  labelText: '장소',
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context
                        .read<ChannelService>()
                        .createChannel(this.name, this.place)
                        .catchError(
                          (e) => showErrorSnackBar(
                            context,
                            e.toString(),
                          ),
                        );
                    Navigator.pop(context);
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
                child: const Text('채널 생성'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChannelFormAlertDialog extends StatefulWidget {
  final ChannelViewModel channel;
  // final GlobalKey<FormState> formKey;
  const ChannelFormAlertDialog({
    super.key,
    // required this.formKey,
    required this.channel,
  });

  @override
  State<ChannelFormAlertDialog> createState() => _ChannelFormAlertDialogState();
}

class _ChannelFormAlertDialogState extends State<ChannelFormAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String name = '';
  String place = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('채널 수정'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.channel.name,
              decoration: const InputDecoration(
                labelText: '채널 이름',
              ),
              onSaved: (value) => this.name = value!,
            ),
            TextFormField(
              initialValue: widget.channel.place,
              decoration: const InputDecoration(
                labelText: '장소',
              ),
              onSaved: (value) => this.place = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await widget.channel
                  .modifyChannel(
                    name: name,
                    place: place,
                  )
                  .then((_) => context.read<ChannelService>().updateChannels());
              if (!context.mounted) return;
              Navigator.pop(context);
              Navigator.pop(context);
            } else {
              setState(() {
                _autovalidateMode = AutovalidateMode.onUserInteraction;
              });
            }
          },
          child: const Text('수정'),
        ),
      ],
    );
  }
}
