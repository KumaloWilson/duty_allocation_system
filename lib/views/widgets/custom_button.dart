import 'package:flutter/material.dart';

import '../constant/colors.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  final Color buttonTextColor;
  final IconData buttonIcon;
  Color? iconColor;
  final double buttonWidth;
  final Color buttonColor;
  final Color? neumophismPrimaryColor;
  final Color? neumophismSecondaryColor;

  CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonIcon,
    this.iconColor,
    this.neumophismPrimaryColor,
    this.neumophismSecondaryColor,
    required this.buttonWidth,
    required this.buttonColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 50,
          width: widget.buttonWidth,
          decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.neumophismSecondaryColor ?? Pallete.oneSecColor,
                offset: const Offset(-1, -1),
                blurRadius: 5,
              ),
              BoxShadow(
                color: widget.neumophismPrimaryColor ?? Pallete.onePrimaryColor,
                offset: const Offset(1, 1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.buttonText,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: widget.buttonTextColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  widget.buttonIcon,
                  color: widget.iconColor ?? widget.buttonTextColor,
                  size: 22,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
