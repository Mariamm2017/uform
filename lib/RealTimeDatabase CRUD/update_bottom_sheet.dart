import 'package:flutter/material.dart';
import 'package:u_form/RealTimeDatabase%20CRUD/real_tim_crud.dart';

import '../widget/custom_datepicker.dart';
import '../widget/custom_text.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController dobController = TextEditingController();
final TextEditingController ageController = TextEditingController();
final TextEditingController addressController = TextEditingController();

void updateBottomSheet(BuildContext context, String firstName, String lastName,
    String id, String dob, String age, String address) {
  // Initialize controllers with current values
  firstNameController.text = firstName;
  lastNameController.text = lastName;
  dobController.text = dob;
  ageController.text = age; // Placeholder for age
  addressController.text = address;

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
                "Update User Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // First Name TextField
            CustomTextField(
              controller: firstNameController,
              label: "First Name",
              hintText: "eg. Ram",
              prefixIcon: Icons.person,
            ),
            // Last Name TextField
            CustomTextField(
              controller: lastNameController,
              label: "Last Name",
              hintText: "eg. Kumar",
              prefixIcon: Icons.person_outline,
            ),
            // Date of Birth TextField
            CustomDatePickerField(
              controller: dobController,
              label: "Date of Birth",
              hintText: "Select Date",
              prefixIcon: Icons.calendar_today,
            ),
            // Age TextField (calculated automatically after DOB selection)
            CustomTextField(
              controller: ageController,
              label: "Age",
              hintText: "eg. 30",
              prefixIcon: Icons.accessibility,
              keyboardType: TextInputType.number,
            ),
            // Address TextField
            CustomTextField(
              controller: addressController,
              label: "Address",
              hintText: "eg. UK",
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Validate all fields
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

                // Update data in Firebase Realtime Database
                databaseReference.child(id).update({
                  'first_name': firstNameController.text,
                  'last_name': lastNameController.text,
                  'dob': dobController.text,
                  'age': ageController.text,
                  'address': addressController.text,
                });

                // Dismiss the bottom sheet
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                "UPDATE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
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
