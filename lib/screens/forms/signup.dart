import 'package:flutter/material.dart';

import 'package:weplan/screens/forms/validator.dart';

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
  String? name = '';
  String? phone = '';
  String? email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              //name
              TextFormField(
                autofillHints: const [AutofillHints.name],
                validator: (value) => validate(value, Validator.name),
                onSaved: (value) => name = value!,
                decoration: const InputDecoration(
                  labelText: '이름',
                ),
              ),

              //phone
              TextFormField(
                autofillHints: const [
                  AutofillHints.telephoneNumber
                ], //동작 안해서 일단 주석처리 했음
                validator: (value) => validate(value, Validator.phoneNumber),
                onSaved: (value) => phone = value!,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
              ),

              //email
              TextFormField(
                autofillHints: const [AutofillHints.email],
                validator: (value) => validate(value, Validator.emailAddress),
                onSaved: (value) => email = value!,
                decoration: const InputDecoration(
                  labelText: '이메일',
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Login
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          {
                            'loginId': loginId!,
                            'password': password!,
                          }.toString(),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
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
