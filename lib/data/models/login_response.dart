import 'package:json_annotation/json_annotation.dart';
import 'tecnico.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String idTecnico;

  LoginResponse({required this.idTecnico});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(idTecnico: json['idTecnico']);
  }
}

