import 'package:json_annotation/json_annotation.dart';

part 'csrf_response.g.dart';

@JsonSerializable()
class CsrfResponse {
  final String csrf_token;

  CsrfResponse({required this.csrf_token});

  factory CsrfResponse.fromJson(Map<String, dynamic> json) => _$CsrfResponseFromJson(json);
}
