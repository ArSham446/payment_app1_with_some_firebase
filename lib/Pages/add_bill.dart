import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/data_controller.dart';
import '../controllers/firebacecontroler.dart';

class AddBills extends StatefulWidget {
  const AddBills({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBillsState createState() => _AddBillsState();
}

class _AddBillsState extends State<AddBills> {
  final DataController _controller = Get.put(DataController());
  // Define the controllers for the text fields
  final brand_nameController = TextEditingController();
  final dueController = TextEditingController();
  final dueinfoController = TextEditingController();
  final idController = TextEditingController();

  // Define a variable to hold the image file
  File? image;

  // Define a function to get an image from the device's camera or gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedImage!.path);
    });
  }

  // Define the FirebaseController class

  // Create an instance of the FirebaseController class
  final FirebaseController firebaseController = FirebaseController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    brand_nameController.dispose();
    dueController.dispose();
    dueinfoController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Text field for name
              TextField(
                controller: brand_nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                ),
              ),

              // Text field for email
              TextField(
                controller: dueController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                ),
              ),

              // Text field for age
              TextField(
                controller: dueinfoController,
                decoration: const InputDecoration(
                  labelText: "Age",
                  hintText: "Enter your age",
                ),
              ),

              // Button to pick an image
              ElevatedButton(
                onPressed: pickImage,
                child: const Text("Pick Image"),
              ),

              const SizedBox(height: 16),
              // Button to store user data
              SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Get the values from the text fields
                    String brand_name = brand_nameController.text.trim();
                    String dueinfo = dueinfoController.text.trim();
                    int due = int.tryParse(dueController.text.trim()) ?? 0;

                    // Call the storeUserData method of the FirebaseController class
                    firebaseController.storeUserData(
                        brand_name, due, dueinfo, image);

                    // Clear the text fields and image variable
                    brand_nameController.clear();
                    dueController.clear();
                    dueinfoController.clear();
                    setState(() {
                      image = null;
                    });

                    // Show a snackbar to indicate success
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data stored successfully!"),
                      ),
                    );
                    _controller.loadData;
                  },
                  child: const Text("Store User Data"),
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Go Back')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
