import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/channel_service.dart';

class ChannelForm extends StatefulWidget {
  const ChannelForm({super.key});

  @override
  State<ChannelForm> createState() => _ChannelFormState();
}

class _ChannelFormState extends State<ChannelForm> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String name = '';
  String place = '';

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
