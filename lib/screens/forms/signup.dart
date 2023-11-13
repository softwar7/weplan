import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/models/enum/role_type.dart';
import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/auth_service.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SignUpScaffold(),
    ),
  );
}

class SignUpScaffold extends StatefulWidget {
  const SignUpScaffold({super.key});

  @override
  State<SignUpScaffold> createState() => _SignUpScaffoldState();
}

class _SignUpScaffoldState extends State<SignUpScaffold> {
  final _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _passwordVisible = false;

  String? loginId = '';
  String? password = '';
  String? name = '';
  String? phone = '';
  RoleType? roleType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
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
                autofillHints: const [AutofillHints.telephoneNumber],
                validator: (value) => validate(value, Validator.phoneNumber),
                onSaved: (value) => phone = value!,
                decoration: const InputDecoration(
                  labelText: '전화번호',
                ),
              ),

              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthService>().signUp(
                          loginId: loginId!,
                          password: password!,
                          name: name!,
                          phoneNumber: phone!,
                          roleType: roleType!,
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
