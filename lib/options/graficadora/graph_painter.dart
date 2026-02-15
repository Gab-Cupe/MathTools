import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';

class FunctionGraphPainter extends CustomPainter {
  final List<Expression> expressions;
  final double xMin, xMax, yMin, yMax;
  final List<Color> lineColors;
  final double scale;
  final bool isDark;

  FunctionGraphPainter({
    required this.expressions,
    required this.xMin,
    required this.xMax,
    required this.yMin,
    required this.yMax,
    required this.lineColors,
    required this.scale,
    required this.isDark,
  });

  // Variables de estado interno para el cálculo de proyección cuadrada
  late double _unitSize;
  late double _offsetX;
  late double _offsetY;

  void _calculateProjection(Size size) {
    double rangeX = xMax - xMin;
    double rangeY = yMax - yMin;

    // Para que sea cuadrada, la escala (píxeles por unidad) debe ser la misma
    double scaleX = size.width / rangeX;
    double scaleY = size.height / rangeY;
    _unitSize = min(scaleX, scaleY);

    // Centramos el gráfico en el espacio sobrante
    _offsetX = (size.width - (rangeX * _unitSize)) / 2;
    _offsetY = (size.height - (rangeY * _unitSize)) / 2;
  }

  double _toX(double x, Size size) => (x - xMin) * _unitSize + _offsetX;
  double _toY(double y, Size size) =>
      size.height - ((y - yMin) * _unitSize + _offsetY);

  @override
  void paint(Canvas canvas, Size size) {
    _calculateProjection(size);
    _drawGrid(canvas, size);
    _drawAxesAndLabels(canvas, size);

    final context = ContextModel();
    for (var i = 0; i < expressions.length; i++) {
      _drawFunction(
        canvas,
        size,
        expressions[i],
        lineColors[i % lineColors.length],
        context,
      );
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.black.withOpacity(0.05)
      ..strokeWidth = 0.5;

    final step = _calculateGridStep();
    for (double x = (xMin / step).floor() * step; x <= xMax; x += step) {
      double px = _toX(x, size);
      canvas.drawLine(Offset(px, 0), Offset(px, size.height), gridPaint);
    }
    for (double y = (yMin / step).floor() * step; y <= yMax; y += step) {
      double py = _toY(y, size);
      canvas.drawLine(Offset(0, py), Offset(size.width, py), gridPaint);
    }
  }

  void _drawAxesAndLabels(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = isDark ? Colors.white54 : Colors.black54
      ..strokeWidth = 2.0;

    final xAxisY = _toY(0, size);
    final yAxisX = _toX(0, size);

    // Dibujar líneas de los ejes
    if (xAxisY >= 0 && xAxisY <= size.height) {
      canvas.drawLine(Offset(0, xAxisY), Offset(size.width, xAxisY), axisPaint);
    }
    if (yAxisX >= 0 && yAxisX <= size.width) {
      canvas.drawLine(
        Offset(yAxisX, 0),
        Offset(yAxisX, size.height),
        axisPaint,
      );
    }

    // Dibujar Numeritos (Labels)
    final step = _calculateGridStep();
    final textStyle = TextStyle(
      color: isDark ? Colors.white70 : Colors.black54,
      fontSize: 10,
    );

    for (double x = (xMin / step).floor() * step; x <= xMax; x += step) {
      if (x.abs() < 0.001)
        continue; // No dibujar el 0 en los ejes para no amontonar
      _drawText(
        canvas,
        x.toStringAsFixed(x % 1 == 0 ? 0 : 1),
        Offset(_toX(x, size), xAxisY.clamp(10, size.height - 20)),
        textStyle,
      );
    }

    for (double y = (yMin / step).floor() * step; y <= yMax; y += step) {
      if (y.abs() < 0.001) continue;
      _drawText(
        canvas,
        y.toStringAsFixed(y % 1 == 0 ? 0 : 1),
        Offset(yAxisX.clamp(10, size.width - 30), _toY(y, size)),
        textStyle,
      );
    }
  }

  void _drawText(Canvas canvas, String text, Offset pos, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(pos.dx + 4, pos.dy + 2));
  }

  void _drawFunction(
    Canvas canvas,
    Size size,
    Expression expr,
    Color color,
    ContextModel cm,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    bool firstPoint = true;
    double? lastY;
    final double step = (xMax - xMin) / (size.width * 0.8);

    for (double x = xMin; x <= xMax; x += step) {
      try {
        cm.bindVariable(Variable('x'), Number(x));
        final double y = expr.evaluate(EvaluationType.REAL, cm);

        if (y.isFinite && !y.isNaN) {
          final px = _toX(x, size);
          final py = _toY(y, size);

          // Salto de asíntota
          if (lastY != null && (y - lastY).abs() > (yMax - yMin) * 2) {
            firstPoint = true;
          }

          if (firstPoint) {
            path.moveTo(px, py);
            firstPoint = false;
          } else {
            path.lineTo(px, py);
          }
          lastY = y;
        } else {
          firstPoint = true;
          lastY = null;
        }
      } catch (_) {
        firstPoint = true;
      }
    }
    canvas.drawPath(path, paint);
  }

  double _calculateGridStep() {
    final range = xMax - xMin;
    if (range <= 0) return 1.0;
    final exponent = (log(range) / ln10).floor();
    double step = pow(10, exponent).toDouble() / 2;
    return step == 0 ? 1.0 : step;
  }

  @override
  bool shouldRepaint(covariant FunctionGraphPainter oldDelegate) => true;
}
