import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final IconData buttonIcon;
  Color? iconColor;
  final Color buttonColor;
  final Color? neumophismPrimaryColor;
  final Color? neumophismSecondaryColor;
  final void Function() onTap;

  CustomButton({
    Key? key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonIcon,
    this.iconColor,
    this.neumophismPrimaryColor,
    this.neumophismSecondaryColor,
    required this.buttonColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: neumophismSecondaryColor ?? Colors.black,
              offset: const Offset(-1, -1),
              blurRadius: 2,
            ),
            BoxShadow(
              color: neumophismPrimaryColor ?? Colors.black,
              offset: const Offset(1, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: buttonTextColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                buttonIcon,
                color: iconColor ?? buttonTextColor,
                size: 22,
              )
            ],
          ),
        ),
      ),
    );
  }
}
