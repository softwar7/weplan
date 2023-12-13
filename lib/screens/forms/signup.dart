import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weplan/components/snackbar.dart';
import 'package:weplan/models/enum/role_type.dart';
import 'package:weplan/screens/forms/validator.dart';
import 'package:weplan/services/auth_service.dart';

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
  String? adminPassword = '';

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
      body: SingleChildScrollView(
        child: Container(
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

                const SizedBox(height: 15),
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
                const SizedBox(height: 15),
                TextFormField(
                  autofillHints: const [AutofillHints.name],
                  validator: (value) => validate(value, Validator.name),
                  onSaved: (value) => name = value!,
                  decoration: const InputDecoration(
                    labelText: '이름',
                  ),
                ),

                //phone
                const SizedBox(height: 15),
                TextFormField(
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (value) => validate(value, Validator.phoneNumber),
                  onSaved: (value) => phone = value!,
                  decoration: const InputDecoration(
                    labelText: '전화번호',
                  ),
                ),

                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: roleType == RoleType.ADMIN,
                          onChanged: (value) => setState(() {
                            // toggle between admin and guest
                            roleType = value! ? RoleType.ADMIN : RoleType.GUEST;
                          }),
                        ),
                        const Text('관리자'),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  enabled: roleType == RoleType.ADMIN,
                  validator: (value) => roleType == RoleType.ADMIN
                      ? validate(value, Validator.adminPassword)
                      : null,
                  onSaved: (value) => adminPassword = value!,
                  decoration: const InputDecoration(
                    labelText: '관리자 코드',
                  ),
                ),

                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context
                            .read<AuthService>()
                            .signUp(
                              loginId: loginId!,
                              password: password!,
                              name: name!,
                              phoneNumber: phone!,
                              roleType: roleType,
                              adminPassword: roleType == RoleType.ADMIN
                                  ? adminPassword
                                  : null,
                            )
                            .then((value) {
                          showSnackBar(context, '회원가입에 성공했습니다.');
                          Navigator.pop(context);
                        }).catchError((e) {
                          String message = e.response?.statusMessage ??
                              e.message ??
                              'Unknown Error';
                          showErrorSnackBar(context, message);
                          throw e;
                        });
                      } else {
                        setState(() {
                          _autovalidateMode =
                              AutovalidateMode.onUserInteraction;
                        });
                      }
                    },
                    child: const Text('회원가입'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
