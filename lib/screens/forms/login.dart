import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/screens/forms/signup.dart';
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
        title: const Text(
          'WePlan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'NanumGothic',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? 'assets/weplan_logo_trans_light.png'
                    : 'assets/weplan_logo_trans_dark.png',
                width: 256.54,
                height: 111.83,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.fromLTRB(40, 80, 40, 0), //메인화면 하단 컨테이너 간격
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofillHints: const [AutofillHints.username],
                      //change the height of the text field

                      validator: (value) => validate(value, Validator.loginId),
                      onSaved: (value) => loginId = value!,

                      textAlign: TextAlign.end, //입력이 맨 뒤에서 시작
                      decoration: const InputDecoration(
                        labelText: '아이디',
                      ),
                    ),
                    const SizedBox(height: 10), //아이디와 비밀번호 사이 간격 띄우기
                    TextFormField(
                      obscureText: !_passwordVisible,
                      autofillHints: const [AutofillHints.password],
                      validator: (value) => validate(value, Validator.password),
                      onSaved: (value) => password = value!,
                      textAlign: TextAlign.end, //입력이 맨 뒤에서 시작
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
                    const SizedBox(height: 40),

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
                            _autovalidateMode =
                                AutovalidateMode.onUserInteraction;
                          });
                        }
                      },
                      child: const Text('Login'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScaffold(),
                          ),
                        );
                      },
                      child: const Text('회원가입'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
