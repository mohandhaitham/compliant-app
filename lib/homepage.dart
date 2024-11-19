import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:work_project/services/camera.dart';



class MainPage extends StatefulWidget {
  final int categoryId; // Add categoryId parameter

  MainPage({required this.categoryId}); //
  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  bool _locationRetrieved = false;
  TextEditingController _descriptionController = TextEditingController();
  double? _latitude;  // Declare latitude
  double? _longitude; // Declare longitude
  String? _selectedValue; // Variable to store the selected value
  String? _attachedFilePath;



// Request storage permission before picking a file
  Future<void> _requestPermissions() async {
    await Permission.storage.request();
  }


// Function to pick a file
  Future<String?> pickAndAttachFile() async {
    await _requestPermissions();
    // Pick a file using the file picker plugin
    final result = await FilePicker.platform.pickFiles();

    // Check if the file is selected and return the path
    if (result != null && result.files.isNotEmpty) {
      // Log the selected file info (for debugging)
      print("File selected: ${result.files.single.path}");

      // Return the file path
      return result.files.single.path;
    }
    return null; // Return null if no file was picked
  }




  Future<void> _submitComplaint() async {
    if (_selectedValue == null || _descriptionController.text.isEmpty) {
      _showError('Please fill in all required fields.');
      return;
    }
    if (_attachedFilePath == null || _attachedFilePath!.isEmpty) {
      _showError('Please attach a file.');
      return;
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://bilalsas.pythonanywhere.com/api/complaint/'),
      );

      // Format latitude and longitude
      final formattedLatitude = _latitude != null
          ? _latitude!.toStringAsFixed(6) // Limit to 6 decimal places
          : "-";
      final formattedLongitude = _longitude != null
          ? _longitude!.toStringAsFixed(6) // Limit to 6 decimal places
          : "-";

      // Add form fields
      request.fields['category'] = widget.categoryId.toString();
      request.fields['description'] = _descriptionController.text;
      request.fields['title'] = _selectedValue!;
      request.fields['latitude'] = formattedLatitude;
      request.fields['longitude'] = formattedLongitude;

      // Add the file to the request
      if (_attachedFilePath != null && _attachedFilePath!.isNotEmpty) {
        final multipartFile = await http.MultipartFile.fromPath(
          'attachment[0][attachment]',  // Correct nested structure
          _attachedFilePath!,
        );
        request.files.add(multipartFile);
      }

      // Send the request
      final response = await request.send();

      if (response.statusCode == 201) {
        _showSuccess('Complaint submitted successfully.');
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody');  // Log the response from the API
      } else {
        final responseBody = await response.stream.bytesToString();
        _showError('Failed to submit complaint: $responseBody');
        print('Error response: $responseBody');  // Log the error response
      }
    } catch (e) {
      _showError('Error submitting complaint: $e');
    }
  }







  void _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Show an error if location services are not enabled
        _showError('Location services are disabled. Please enable them.');
        return;
      }

      // Request permission for location access
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission if not granted
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Location permission denied. Please grant permission.');
          return;
        }
      }

      // Get the current position if all checks pass


      // Display the location if successful
      // Update the state with the current location
      setState(() {
        _latitude = position.latitude;  // Update latitude
        _longitude = position.longitude; // Update longitude
        _locationRetrieved = true;
      });
      print("Latitude: $_latitude");
      print("Longitude: $_longitude");

      _showSuccess('Current Location: Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    } catch (e) {
      // Show error message if an exception occurs
      _showError('Failed to get location. Please try again.');
    }
  }

  // Show success message
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }







  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cover.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Main Page',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: Column(

          children: [
            SizedBox(height: 20,),
            Container(
              width: 350, // Width of the box
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // Solid white background
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12, // Subtle shadow for a modern effect
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left for readability
                children: [
                  // Selection Dropdown on the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: DropdownButton<String>(
                      items: [
                        DropdownMenuItem(
                          value: "Option 1",
                          child: Text("Option 1"),
                        ),
                        DropdownMenuItem(
                          value: "Option 2",
                          child: Text("Option 2"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value; // Update the selected value
                        });
                        print(": $value");
                      },
                      value: _selectedValue, // Show the selected value
                      hint: Text('اختر الفئة', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      underline: Container(), // Remove underline for a cleaner look
                      style: TextStyle(fontSize: 16, color: Colors.black), // Style for dropdown items
                    ),
                  ),
                  SizedBox(height: 16),

                  // Description Input
                  Center(
                    child: Text(
                      'وصف الحالة',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),

                    ),
                  ),
                  SizedBox(height: 8),
                  // RTL Input Field
                  TextField(
                    controller: _descriptionController,
                    textAlign: TextAlign.right, // Align text to the right
                    textDirection: TextDirection.rtl, // Ensure RTL text direction
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "اكتب وصف الحالة هنا", // Placeholder in Arabic
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[100], // Light gray background
                      filled: true,
                    ),
                  ),


                  SizedBox(height: 16),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Take Photo Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          await openCameraAndAttachPhoto((photoPath) {
                            setState(() {});
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(Icons.camera_alt_rounded, color: Colors.white),
                        label: Text("التقط صورة", style: TextStyle(color: Colors.white)),
                      ),

                      // Upload File Button
                      ElevatedButton.icon(
                        onPressed: () async {
                          String? pickedFilePath = await pickAndAttachFile();
                          if (pickedFilePath != null) {
                            setState(() {
                              _attachedFilePath = pickedFilePath; // Store the file path as a String
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(Icons.upload_file, color: Colors.white),
                        label: Text("ارفع ملف", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  if (_attachedFilePath != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'ملف مرفق: ${_attachedFilePath!.split('/').last}',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),

                  // Current Location Button
                  ElevatedButton.icon(
                    onPressed: _getLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(Icons.location_on, color: Colors.white),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("موقعك الحالي", style: TextStyle(color: Colors.white)),
                        if (_locationRetrieved)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.check_circle, color: Colors.green),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            // ElevatedButton(
            //   onPressed: _getLocation,
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text(
            //         "موقعك الحالي",
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       if (_locationRetrieved)
            //         Icon(Icons.check_circle, color: Colors.green),
            //     ],
            //   ),
            // ),

            SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {
            _submitComplaint();
            print("send data ");
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // Add gradient background
            backgroundColor: Colors.transparent, // Make background transparent
            foregroundColor: Colors.transparent, // Make foreground transparent
            shadowColor: Colors.transparent, // Make shadow transparent

          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.green!, // Start color
                  Colors.green!, // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            child: Text(
              "ارسل الشكوة",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
            SizedBox(height: 20,),
            // ElevatedButton(
            //   onPressed: () {
            //     print("Top button pressed");
            //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   child: Text("التالي",
            //     style: TextStyle(color: Colors.black),),
            //
            // ),
             SizedBox(height: 150,),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Center(

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey[400]!, // Start color
                          Colors.grey[200]!, // End color
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10), backgroundColor: Colors.transparent,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        print('Bottom button pressed');
                      },
                      child: Text(
                        'القائمة',
                        style: TextStyle(fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
