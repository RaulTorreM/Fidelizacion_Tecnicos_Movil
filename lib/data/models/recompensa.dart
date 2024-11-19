import 'package:json_annotation/json_annotation.dart';

part 'recompensa.g.dart';


@JsonSerializable()
class Recompensa {
  final String idRecompensa;
  final String tipoRecompensa;
  final String descripcionRecompensa;
  final int costoPuntos_Recompensa;

  Recompensa({
    required this.idRecompensa,
    required this.tipoRecompensa,
    required this.descripcionRecompensa,
    required this.costoPuntos_Recompensa,
  });

  factory Recompensa.fromJson(Map<String, dynamic> json) => _$RecompensaFromJson(json);
  Map<String, dynamic> toJson() => _$RecompensaToJson(this);
}
