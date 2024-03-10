import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/utils/colors/pallete.dart';
import 'package:platform_x_universal/views/widgets/custom_button.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Lottie.asset(
            Assets.networkErrorAnimation,
            height: 250
          ),
          Text(
            'Network Error\nCheck your connection and try again',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12
            ),
          ),

          SizedBox(
            height: 16,
          ),

          CustomButton(
              btnColor: Pallete.primaryColor,
              width: 200,
              borderRadius: 10,
              onTap: onTap,
              child: Text(
                'Try Again',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),
              )
          )
        ],
      ),
    );
  }
}
