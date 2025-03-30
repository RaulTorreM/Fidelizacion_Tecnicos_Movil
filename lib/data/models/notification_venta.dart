import 'package:json_annotation/json_annotation.dart';

part 'notification_venta.g.dart';

@JsonSerializable()
class TecnicoNotification {
  final int id;
  @JsonKey(name: 'idTecnico')
  final String idTecnico;
  @JsonKey(name: 'idVentaIntermediada')
  final String? idVentaIntermediada;
  final String description;
  @JsonKey(fromJson: _activeFromJson, toJson: _activeToJson)
  final bool active;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  TecnicoNotification({
    required this.id,
    required this.idTecnico,
    this.idVentaIntermediada,
    required this.description,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TecnicoNotification.fromJson(Map<String, dynamic> json) =>
      _$TecnicoNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$TecnicoNotificationToJson(this);

  // Conversión para el campo active (int a bool)
  static bool _activeFromJson(int active) => active == 1;
  static int _activeToJson(bool active) => active ? 1 : 0;
}