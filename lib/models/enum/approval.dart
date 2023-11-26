// ignore_for_file: constant_identifier_names

class Approval {
  static const APPROVED = Approval('APPROVED');
  static const PENDING = Approval('PENDING');
  static const REJECTED = Approval('REJECTED');

  final String _value;
  const Approval(this._value);

  static List<Approval> get values => [APPROVED, PENDING, REJECTED];

  @override
  String toString() => _value;

  factory Approval.fromJson(String json) {
    if (json == 'APPROVED') {
      return APPROVED;
    } else if (json == 'PENDING') {
      return PENDING;
    } else if (json == 'REJECTED') {
      return REJECTED;
    } else {
      throw Error();
    }
  }

  String toJson() => toString();
}
