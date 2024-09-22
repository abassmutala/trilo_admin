import 'package:flutter/material.dart';
import 'package:trilo_admin/constants/ui_constants.dart';

class ShimmerLoader extends StatelessWidget {
  final Color startColor;
  final Color endColor;

  const ShimmerLoader(
      {super.key, required this.startColor, required this.endColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.tny),
      height: 64.0,
      decoration: BoxDecoration(
        color: startColor,
        borderRadius: Corners.smBorder,
      ),
      child: ShimmerEffect(color: endColor),
    );
  }
}

class ShimmerEffect extends StatefulWidget {
  final Color color;
  final BorderRadiusGeometry? borderRadius;

  const ShimmerEffect({super.key, required this.color, this.borderRadius});

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment(_animation.value, 0.0),
                end: Alignment(_animation.value - 1.0, 0.0),
                colors: [
                  theme.textTheme.labelMedium?.color ??
                      Colors.grey.withOpacity(0.1),
                  widget.color,
                  // Colors.grey.withOpacity(0.1)
                ],
                stops: const [0.0, 1.0],
              ).createShader(bounds);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: widget.borderRadius ?? Corners.smBorder),
            ),
          );
        });
  }
}
