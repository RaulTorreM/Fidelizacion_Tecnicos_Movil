import 'package:json_annotation/json_annotation.dart';
import 'tecnico.dart';

part 'tecnico_response.g.dart';

@JsonSerializable()
class TecnicoResponse {
  @JsonKey(name: 'tecnico')
  final Tecnico tecnico;

  TecnicoResponse({required this.tecnico});

  factory TecnicoResponse.fromJson(Map<String, dynamic> json) => _$TecnicoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TecnicoResponseToJson(this);
}
