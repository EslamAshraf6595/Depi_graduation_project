import 'package:control_style/control_style.dart';
import 'package:final_project/constans/colors.dart';
import 'package:final_project/constans/text_styles.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final VoidCallback _callback;
  final double _radius = 10;
  final String imagePath;
  final String text;
  OutlineButton({
    required VoidCallback onPressed,
    required this.imagePath,
    required this.text,
  })  : this._painter = _GradientPainter(),
        this._callback = onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: BoxConstraints(minWidth: double.infinity, minHeight: 60),
            child: TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(imagePath),
                  SizedBox(
                    width: 10,
                  ),
                  Text(text, style: TextStyles.smallText.copyWith(
                      color: AppColors.white
                  ),),
                ],
              ),
              style: TextButton.styleFrom(
                  shape: DecoratedOutlinedBorder(
                    shadow: [
                      BoxShadow(
                        color: AppColors.outlinedButtonShadow,
                        blurRadius: 8,
                      )
                    ],
                    child: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius = 10;
  final double strokeWidth = 2;
  final Gradient gradient = LinearGradient(
    colors: [AppColors.primaryLight, AppColors.primary],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );


  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class Paths {
  static String logoPath = 'assets/helios_logo.png';
}