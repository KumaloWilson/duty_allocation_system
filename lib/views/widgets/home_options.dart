import 'package:flutter/material.dart';

class HomeOption extends StatelessWidget {
  final AssetImage backgroundImage;
  final Alignment alignment;
  final Text text;
  final Color backgroundColor;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final void Function() onTap;
  
  const HomeOption({super.key, required this.backgroundImage, required this.alignment, required this.text, required this.backgroundColor, this.columnCrossAxisAlignment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(
            left: 12,
            top: 12
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: backgroundColor.withOpacity(0.2),
              image: DecorationImage(
                  alignment: alignment,
                  image: backgroundImage
              ),
              borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: columnCrossAxisAlignment!,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text
            ],
          ),
        ),
      ),
    );
  }
}
