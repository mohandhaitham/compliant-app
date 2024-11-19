import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'FAQPage.dart';
import 'FeedbackPage.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String? complaintDetails;
  String? complaintCategory;
  String? contactInfo;
  File? attachedFile;

  final List<String> categories = [
    'Product Issue',
    'Service Issue',
    'Billing Problem',
    'Other'
  ];

  // Function to pick an image/file from gallery
  Future<void> pickFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        attachedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit Complaint',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Complaint Details Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Complaint Details',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter complaint details';
                  }
                  complaintDetails = value;
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Category Selection Dropdown
              DropdownButtonFormField<String>(
                value: complaintCategory,
                hint: Text('Select Category'),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    complaintCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Contact Information Field
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact Information',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact information';
                  }
                  contactInfo = value;
                  return null;
                },
              ),
              SizedBox(height: 20),

              // File Attachment Button
              ElevatedButton.icon(
                onPressed: pickFile,
                icon: Icon(Icons.attach_file),
                label: Text(attachedFile == null
                    ? 'Attach a file or image'
                    : 'File attached: ${attachedFile!.path.split('/').last}'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Complaint submitted successfully!')),
                    );
                  }
                },
                child: Text(
                  'Submit Complaint',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
              SizedBox(height: 30),

              // Row for FAQ and Feedback buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // FAQ Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FAQPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen, // Light Green color
                      minimumSize: Size(120, 40), // Smaller size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "FAQ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  // Feedback Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FeedbackPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen, // Light Green color
                      minimumSize: Size(120, 40), // Smaller size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "Feedback",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
