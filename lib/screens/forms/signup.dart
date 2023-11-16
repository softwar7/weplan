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
  RoleType roleType = RoleType.GUEST;

  String? validate(String? value, bool Function(String) validator) {
    try {
      if (value == null) throw '해당 필드를 입력해주세요. ';
      if (validator(value)) return null;
      throw 'Unknown error';
    } catch (e) {
      return e.toString();
    }
  }

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
              DropdownButtonFormField<RoleType>(
                value: roleType,
                items: const [
                  DropdownMenuItem(
                    value: RoleType.GUEST,
                    child: Text('일반 회원'),
                  ),
                  DropdownMenuItem(
                    value: RoleType.ADMIN,
                    child: Text('관리자'),
                  ),
                ],
                onChanged: (RoleType? value) {
                  roleType = value!;
                },
                decoration: const InputDecoration(
                  labelText: '계정 유형',
                ),
              ),
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

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthService>().signUp(
                          loginId: loginId!,
                          password: password!,
                          name: name!,
                          phoneNumber: phone!,
                          roleType: roleType,
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
