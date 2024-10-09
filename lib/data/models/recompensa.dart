import 'package:json_annotation/json_annotation.dart';

part 'recompensa.g.dart';

@JsonSerializable()

class Recompensa {
  final String idRecompensa;
  final String tipoRecompensa;
  final String descripcionRecompensa;
  final int costoPuntosRecompensa;

  Recompensa({
    required this.idRecompensa,
    required this.tipoRecompensa,
    required this.descripcionRecompensa,
    required this.costoPuntosRecompensa,
  });

  factory Recompensa.fromJson(Map<String, dynamic> json) {
    return Recompensa(
      idRecompensa: json['idRecompensa'],
      tipoRecompensa: json['tipoRecompensa'],
      descripcionRecompensa: json['descripcionRecompensa'],
      costoPuntosRecompensa: json['costoPuntos_Recompensa'],
    );
  }
}
