import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/services/auth_service.dart';
import 'package:weplan/services/validator.dart';

void main() {
  runApp(
    const MaterialApp(
      home: LoginScaffold(),
    ),
  );
}

class LoginScaffold extends StatefulWidget {
  const LoginScaffold({super.key});

  @override
  State<LoginScaffold> createState() => _LoginScaffoldState();
}

class _LoginScaffoldState extends State<LoginScaffold> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _passwordVisible = false;

  String? loginId = '';
  String? password = '';

  String? validate(String? value, bool Function(String) validator) {
    try {
      if (value == null || value.isEmpty)
        throw '해당 필드를 입력해주세요. ';
      else if (validator(value)) return null;
      throw 'Unknown error';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WePlan Login'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofillHints: const [AutofillHints.username],
                validator: (value) => validate(value, Validator.loginId),
                onSaved: (value) => loginId = value!,
                decoration: const InputDecoration(
                  labelText: '아이디',
                ),
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                autofillHints: const [AutofillHints.password],
                validator: (value) => validate(value, Validator.password),
                onSaved: (value) => password = value!,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Login
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text(
                    //       {
                    //         'loginId': loginId!,
                    //         'password': password!,
                    //       }.toString(),
                    //     ),
                    //   ),
                    // );
                    context.read<AuthService>().signIn(
                          loginId: loginId!,
                          password: password!,
                        );
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
