import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';
import 'package:trackizer/common/App_Colors.dart';

class CustomArcPainter extends CustomPainter {
  final double width;
  final double start;
  final double end;
  final double blurWidth;

  CustomArcPainter({
    super.repaint,
    this.width = 15,
    this.start = 0,
    this.end = 270,
    this.blurWidth = 6,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    var gradientColor = LinearGradient(
      colors: [AppColors.secondary, AppColors.secondary50, AppColors.secondary],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    var startVal = 135 + start;

    Paint activePaint = Paint()..shader = gradientColor.createShader(rect);

    activePaint.style = PaintingStyle.stroke;
    activePaint.strokeWidth = width;
    activePaint.strokeCap = StrokeCap.round;

    Paint backgroundPaint = Paint()..shader;
    backgroundPaint.color = AppColors.gray70.withOpacity(0.7);
    backgroundPaint.style = PaintingStyle.stroke;
    backgroundPaint.strokeWidth = width;
    backgroundPaint.strokeCap = StrokeCap.round;

    Paint shadowPaint =
        Paint()
          ..color = AppColors.secondary.withOpacity(0.3)
          ..strokeWidth = width + blurWidth
          ..style = PaintingStyle.stroke
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawArc(
      rect,
      radians(startVal),
      radians(270),
      false,
      backgroundPaint,
    );

    Path path = Path();
    path.addArc(rect, radians(startVal), radians(end));
    canvas.drawPath(path, shadowPaint);
    canvas.drawArc(rect, radians(startVal), radians(end), false, activePaint);
  }

  @override
  bool shouldRepaint(CustomArcPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CustomArcPainter oldDelegate) => false;
}
