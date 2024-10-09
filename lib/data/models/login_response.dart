class LoginResponse {
  final String status;
  final String message;
  final String idTecnico;

  LoginResponse({
    required this.status,
    required this.message,
    required this.idTecnico,
  });

  // Método para crear una instancia de LoginResponse a partir de un JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      idTecnico: json['idTecnico'],
    );
  }

  // Método para convertir la instancia en JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'idTecnico': idTecnico,
    };
  }
}
