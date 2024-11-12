import 'package:flutter/material.dart';
import 'package:u_form/RealTimeDatabase%20CRUD/real_tim_crud.dart';

import '../widget/custom_datepicker.dart';
import '../widget/custom_text.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController dobController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController addressController = TextEditingController();

void createBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Add User Details",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber, // Accent color for title
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // First Name Text Field
              CustomTextField(
                controller: firstNameController,
                label: "First Name",
                hintText: "eg. Ram",
                prefixIcon: Icons.person,
              ),

              // Last Name Text Field
              CustomTextField(
                controller: lastNameController,
                label: "Last Name",
                hintText: "eg. Kumar",
                prefixIcon: Icons.person,
              ),

              // Date of Birth Text Field
              CustomDatePickerField(
                controller: dobController,
                label: "Date of Birth",
                hintText: "Select Date",
                prefixIcon: Icons.calendar_today,
              ),

              // Age Text Field
              CustomTextField(
                controller: ageController,
                label: "Age",
                hintText: "eg. 30",
                prefixIcon: Icons.accessibility_new,
                keyboardType: TextInputType.number,
              ),

              // Address Text Field
              CustomTextField(
                controller: addressController,
                label: "Address",
                hintText: "eg. UK",
                prefixIcon: Icons.location_on,
              ),

              const SizedBox(height: 20),

              // Add Button
              ElevatedButton(
                onPressed: () {
                  // Validate fields: Check if any of the fields are empty
                  if (firstNameController.text.isEmpty) {
                    showErrorDialog(context, "Please enter First Name");
                    return;
                  }
                  if (lastNameController.text.isEmpty) {
                    showErrorDialog(context, "Please enter Last Name");
                    return;
                  }
                  if (dobController.text.isEmpty) {
                    showErrorDialog(context, "Please select Date of Birth");
                    return;
                  }

                  // If age is not entered, calculate age from DOB
                  if (ageController.text.isEmpty &&
                      dobController.text.isNotEmpty) {
                    int age = calculateAgeFromDOB(dobController.text);
                    if (age == -1) {
                      showErrorDialog(context, "Invalid Date of Birth format");
                      return;
                    }
                    ageController.text = age.toString();
                  }

                  if (addressController.text.isEmpty) {
                    showErrorDialog(context, "Please enter Address");
                    return;
                  }

                  // Save the data to the database
                  final id = DateTime.now().microsecond.toString();
                  databaseReference.child(id).set({
                    'first_name': firstNameController.text.toString(),
                    'last_name': lastNameController.text.toString(),
                    'dob': dobController.text.toString(),
                    'age': ageController.text.toString(),
                    'address': addressController.text.toString(),
                    'id': id, // Unique ID
                  });

                  // Clear the controllers
                  firstNameController.clear();
                  lastNameController.clear();
                  dobController.clear();
                  ageController.clear();
                  addressController.clear();

                  // Dismiss keyboard and close bottom sheet
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.amber, // Button color
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5, // Shadow effect
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      });
}

// Function to show error dialog
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error"),
        content: Row(
          children: [
            Icon(
              Icons.error, // Error icon
              color: Colors.red, // Icon color (red for error)
            ),
            SizedBox(
              width: 10,
            ), // Add some spacing between the icon and the message
            Expanded(
              child: Text(message), // Error message
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
