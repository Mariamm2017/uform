import 'dart:math';

import 'package:flutter/material.dart';
import 'package:u_form/RealTimeDatabase%20CRUD/update_bottom_sheet.dart';
import 'package:u_form/RealTimeDatabase%20CRUD/create_bottom_sheet.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

final databaseReference = FirebaseDatabase.instance.ref("user");

class RealTimeCRUDEdatabase extends StatefulWidget {
  const RealTimeCRUDEdatabase({super.key});

  @override
  State<RealTimeCRUDEdatabase> createState() => _RealTimeDatabaseState();
}

class _RealTimeDatabaseState extends State<RealTimeCRUDEdatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Realtime Database CRUD"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: databaseReference,
                  itemBuilder: (context, snapshot, index, animation) {
                    String firstName =
                        snapshot.child('first_name').value.toString();
                    String lastName =
                        snapshot.child('last_name').value.toString();
                    String address = snapshot.child('address').value.toString();
                    String age = snapshot.child('age').value.toString();
                    String dob = snapshot.child('dob').value.toString();
                    String id = snapshot.child('id').value.toString();

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          "$firstName $lastName",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(address),
                        leading: CircleAvatar(
                          radius: 25,
                          child: Text(
                            firstName.isNotEmpty
                                ? firstName[0].toUpperCase()
                                : "",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor:
                              getRandomColor(), // Set the random color here// You can change the color as needed
                        ),
                        trailing: PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            // For Update Operation
                            PopupMenuItem<int>(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  updateBottomSheet(
                                    context,
                                    firstName,
                                    lastName,
                                    id,
                                    dob,
                                    age,
                                    address,
                                  );
                                },
                                leading: Icon(Icons.edit, color: Colors.blue),
                                title: Text("Edit",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            ),
                            // For Delete Operation
                            PopupMenuItem<int>(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  databaseReference
                                      .child(snapshot.key!)
                                      .remove();
                                  Navigator.pop(
                                      context); // Close the popup menu
                                },
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text("Delete",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Random red value between 0 and 255
      random.nextInt(256), // Random green value between 0 and 255
      random.nextInt(256), // Random blue value between 0 and 255
      1, // Alpha (opacity) value is 1 (fully opaque)
    );
  }
}
