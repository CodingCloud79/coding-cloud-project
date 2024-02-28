import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeDropdownMenu extends StatelessWidget {
  final String label;
  final List<String> items;
  final String initialValue;
  final String errortext;
  final TextEditingController controller;
  final void Function(String?) onChanged;

  const CustomeDropdownMenu({
    Key? key,
    required this.label,
    required this.items,
    required this.initialValue,
    required this.errortext,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: DropdownButtonFormField(
        menuMaxHeight: 200,
        hint: Text(
          label,
          style: const TextStyle(fontSize: 20),
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 12, top: 10),
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          filled: true,
        ),
        isDense: false,
        validator: (value) {
          if (value == null || value == " ") {
            return errortext;
          }
          return null;
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidName(String name) {
  final nameRegex = RegExp(r"^[a-zA-Z]+(([',\.\-\s][a-zA-Z ])?[a-zA-Z]*)*$");
  return nameRegex.hasMatch(name);
}


Widget tff(
  String hinttext,
  TextInputType keyboardtype,
  TextEditingController tffcontroller,
  String label,
  String errortext,
) {
  return TextFormField(
    controller: tffcontroller,
    keyboardType: keyboardtype,
    validator: (value) {
      if (value == '' || value == null) {
        return errortext;
      } else {
        if (hinttext == "Email") {
          bool result = isValidEmail(value);
          if (result) {
            return null;
          } else {
            return "Enter Email like abc@gmail.com";
          }
        }
        if (hinttext == "Name") {
          bool result = isValidName(value);
          if (result) {
            return null;
          } else {
            return " Name Should Contain Alphabets Only ";
          }
        }
        
      }
      return null;
    },
    style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(15),
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(),
      hintStyle: const TextStyle(),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    ),
  );
}

Widget heading(double fontsize, String headingText, FontWeight fontweight) {
  return SizedBox(
    width: double.infinity,
    child: Text(
      headingText,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        fontWeight: fontweight,
        fontSize: fontsize,
      ),
    ),
  );
}
