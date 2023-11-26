// ignore_for_file: constant_identifier_names

class RoleType {
  static const ADMIN = RoleType('ADMIN');
  static const GUEST = RoleType('GUEST');

  final String _value;
  const RoleType(this._value);

  static List<RoleType> get values => [ADMIN, GUEST];

  @override
  String toString() => _value;

  factory RoleType.fromJson(String json) {
    if (json == 'ADMIN') {
      return ADMIN;
    } else if (json == 'GUEST') {
      return GUEST;
    } else {
      throw Error();
    }
  }
  String toJson() => toString();
}
