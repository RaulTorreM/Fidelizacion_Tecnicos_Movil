import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Dibuja un rectángulo que cubra el fondo
    final backgroundPaint = Paint()..color = Color(0xFF60A5FA);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final paint1 = Paint()..color = Color.fromARGB(255, 60, 78, 129); // Color azul vibrante
    final paint2 = Paint()..color = Color.fromARGB(255, 35, 53, 95); // Color más oscuro
    final paint3 = Paint()..color = Color.fromARGB(255, 42, 93, 175); // Color azul claro
    final paint4 = Paint()..color = Color.fromARGB(255, 86, 147, 221); // Color azul suave

    // Dibuja la primera figura
    final path1 = Path();
    path1.moveTo(0, size.height * 0.3);
    path1.lineTo(size.width * 0.5, size.height * 0.1);
    path1.lineTo(size.width, size.height * 0.3);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Dibuja la segunda figura
    final path2 = Path();
    path2.moveTo(0, size.height * 0.5);
    path2.lineTo(size.width * 0.5, size.height * 0.4);
    path2.lineTo(size.width, size.height * 0.5);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint3); // Color azul claro

    // Dibuja la tercera figura
    final path3 = Path();
    path3.moveTo(0, size.height * 0.8);
    path3.lineTo(size.width * 0.5, size.height * 0.9);
    path3.lineTo(size.width, size.height * 0.8);
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint2); // Color oscuro

    // Dibuja la cuarta figura
    final path4 = Path();
    path4.moveTo(size.width * 0.5, size.height * 0.6);
    path4.lineTo(size.width, size.height * 0.7);
    path4.lineTo(size.width, size.height);
    path4.lineTo(size.width * 0.5, size.height);
    path4.close();
    canvas.drawPath(path4, paint4); // Color azul suave
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
