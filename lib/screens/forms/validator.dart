import 'package:weplan/models/enum/role_type.dart';

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

class Validator {
  static bool loginId(String value) {
    // min 6 max 15, starts with letter
    if (RegExp(r'^[A-Za-z][A-Za-z0-9]{5,14}$').hasMatch(value)) {
      return true;
    } else {
      throw '아이디는 6~15 자리여야 합니다.';
    }
  }

  static bool name(String value) {
    // min 1 max 11, don't start or end with whitespace
    if (RegExp(r'^[^\s].{0,9}[^\s]$').hasMatch(value)) {
      return true;
    } else {
      throw '이름은 1~11 자리이며, 공백으로 시작하거나 끝나지 않아야 합니다.';
    }
  }

  static bool phoneNumber(String value) {
    // only numbers, 11 digits
    if (RegExp(r'^[0-9]{10,11}$').hasMatch(value)) {
      return true;
    } else {
      throw '전화번호는 10~11 자리의 -을 제외한 숫자여야 합니다.';
    }
  }

  static bool roleType(String value) {
    if (RoleType.values.map((e) => e.toString()).contains(value)) {
      return true;
    } else {
      throw '권한은 ADMIN 또는 GUEST 여야 합니다.';
    }
  }

  static bool adminPassword(String value) {
    // min 8 max 15
    if (RegExp(r'^.{8,15}$').hasMatch(value)) {
      return true;
    } else {
      throw '관리자 인증번호는 8~15 자리여야 합니다.';
    }
  }

  static bool password(String value) {
    // min 8 max 15 should include number,  small letter
    // capital letter, special character is not necessary
    if (RegExp(r'^(?=.*[0-9])(?=.*[a-z]).{8,15}$').hasMatch(value)) {
      return true;
    } else {
      throw '비밀번호는 8~15 자리의 숫자, 대문자, 소문자, 특수문자를 포함해야 합니다.';
    }
  }

  static bool emailAddress(String value) {
    // min 1 max 128, must be a valid email address
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return true;
    } else {
      throw '이메일 형식이 올바르지 않습니다.';
    }
  }

  String _password = '';

  bool newPassword(String value) {
    _password = value;
    return password(value);
  }

  bool newPasswordCheck(String value) {
    if (value == _password) {
      return true;
    } else {
      throw '비밀번호가 일치하지 않습니다.';
    }
  }
}
