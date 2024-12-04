import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'idTecnico')
  final String idTecnico;

  @JsonKey(name: 'apiKey')
  final String apiKey;

  @JsonKey(name: 'isFirstLogin')
  final bool isFirstLogin;  // Nuevo campo

  LoginResponse({
    required this.status,
    required this.message,
    required this.idTecnico,
    required this.apiKey,
    required this.isFirstLogin,  
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
