// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      idTecnico: json['idTecnico'] as String,
      isFirstLogin: json['isFirstLogin'] as bool,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'idTecnico': instance.idTecnico,
      'isFirstLogin': instance.isFirstLogin,
    };
