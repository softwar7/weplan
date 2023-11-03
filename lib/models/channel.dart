import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  final int id;
  final String name;
  final String place;
  final String createdBy;

  Channel({
    required this.id,
    required this.name,
    required this.place,
    required this.createdBy,
  });

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
  Map<String, dynamic> toJson() => _$ChannelToJson(this);
}
