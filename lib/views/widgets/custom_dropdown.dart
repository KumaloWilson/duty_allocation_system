import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDown extends StatefulWidget {
  late final String selectedValue;
  final List<String> options;
  final String placeHolder;

  CustomDropDown({
    Key? key,
    required this.selectedValue,
    required this.options,
    required this.placeHolder
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.grey
          )
      ),
      child: DropdownButton<String>(
        value: widget.selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue!;
          });
        },
        items: widget.options.map((String dept) {
          return DropdownMenuItem<String>(
            value: dept,
            child: Text(dept),
          );
        }).toList(),
        isExpanded: true,
        underline: const SizedBox(),
        style: const TextStyle(
          color: Colors.black,
        ),
        iconEnabledColor: Colors.black,
        icon: const Icon(Icons.arrow_drop_down),
        hint: Text(
          widget.placeHolder,
          style: TextStyle(color: Colors.grey),
        ),
        elevation: 16,
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.white,
      ),
    );
  }
}
