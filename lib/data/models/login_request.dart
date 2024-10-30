import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String celularTecnico;
  final String password;

  LoginRequest({
    required this.celularTecnico,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'celularTecnico': celularTecnico,
      'password': password,
    };
  }
}