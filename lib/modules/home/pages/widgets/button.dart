import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final double borderWidth;
  final Color borderColor;
  final VoidCallback onPressed;
  final Color textColor;

  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderWidth=0,
    this.borderColor=AppColors.mainText,
    this.textColor=Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme=Theme.of(context);
    return Bounce(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:Border.all(width: borderWidth,color: borderColor) ,
          borderRadius: BorderRadius.circular(15),
          color: AppColors.mainText,
        ),
        child: Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            color:textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}