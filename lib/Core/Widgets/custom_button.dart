import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.borderRadius,
    this.color,
    this.width,
    this.height,
    this.border,
    this.image,
    this.boxShadow,
    this.gradient,
    this.shape,
    required this.child, this.padding,
  });
  final Widget child;
  final double? borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final DecorationImage? image;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BoxShape? shape;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          border: border,
          image: image,
          boxShadow: boxShadow,
          gradient: gradient,
          shape: shape ?? BoxShape.rectangle,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
