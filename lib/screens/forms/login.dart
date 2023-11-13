import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/auth_service.dart';
import 'package:weplan/utils/logger.dart';

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
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context
                        .read<AuthService>()
                        .signIn(
                          loginId: loginId!,
                          password: password!,
                        )
                        .catchError((e) {
                      showErrorSnackBar(
                        context,
                        e.response?.statusMessage ??
                            e.message ??
                            'Unknown Error',
                      );
                      logger.e(e);
                      throw e;
                    });
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
