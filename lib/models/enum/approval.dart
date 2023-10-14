// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum Approval {
  @JsonValue('APPROVED')
  APPROVED,
  @JsonValue('PENDING')
  PENDING,
  @JsonValue('REJECTED')
  REJECTED;
}
