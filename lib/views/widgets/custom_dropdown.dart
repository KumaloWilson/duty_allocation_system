import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final IconData prefixIcon;
  final void Function(String?)? onChanged;
  final bool isEnabled; // New property to enable/disable the dropdown

  CustomDropDown({
    Key? key,
    required this.prefixIcon,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.isEnabled, // Initialize the isEnabled property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isEnabled ? Colors.transparent :Theme.of(context).disabledColor.withOpacity(0.2),
        border: Border.all(
          color: Theme.of(context).disabledColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              prefixIcon,
              color: Theme.of(context).disabledColor,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 9,
            child: DropdownButton<String>(
              value: selectedValue,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
              onChanged: isEnabled ? onChanged : null, // Set onChanged callback based on isEnabled
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(
                color: Colors.black,
              ),
              iconEnabledColor: Colors.black,
              icon: Icon(Icons.arrow_drop_down),
              hint: Text(
                'Select',
                style: TextStyle(color: Colors.grey),
              ),
              elevation: 16,
              borderRadius: BorderRadius.circular(10),
              dropdownColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
