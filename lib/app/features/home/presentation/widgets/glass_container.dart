import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final String mainText;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? iconSize;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.mainText,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor?.withOpacity(0.15),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),

            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: iconSize),
                    const SizedBox(width: 2),
                  ],

                  Text(
                    mainText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
