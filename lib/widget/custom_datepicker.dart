import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../RealTimeDatabase CRUD/create_bottom_sheet.dart';

/// Custom Date Picker Field with Automatic Age Calculation
class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;

  const CustomDatePickerField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(prefixIcon, color: Colors.amber),
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            // Set the picked date in the controller
            controller.text = pickedDate
                .toLocal()
                .toString()
                .split(' ')[0]; // Format as yyyy-MM-dd

            // Automatically calculate the age when the DOB is selected
            int age = calculateAgeFromDOB(controller.text);

            // Set the calculated age into the age field
            ageController.text = age.toString();
          }
        },
      ),
    );
  }
}

/// Function to Calculate Age from DOB
int calculateAgeFromDOB(String dob) {
  try {
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  } catch (e) {
    return -1; // Return -1 if date format is invalid
  }
}
