
class Oficio {
  final int idOficio;
  final String nombreOficio;

  Oficio({required this.idOficio, required this.nombreOficio});

  // Método para convertir un mapa a un objeto Oficio
  factory Oficio.fromJson(Map<String, dynamic> json) {
    return Oficio(
      idOficio: json['idOficio'],
      nombreOficio: json['nombre_Oficio'],
    );
  }
}
