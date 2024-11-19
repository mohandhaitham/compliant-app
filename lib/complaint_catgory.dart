import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'api_services/auth_service.dart';
import 'homepage.dart';
import 'login.dart';

class DynamicButtonsPage extends StatefulWidget {
  late  String token;

  DynamicButtonsPage({required this.token});
  @override
  _DynamicButtonsPageState createState() => _DynamicButtonsPageState();
}

class _DynamicButtonsPageState extends State<DynamicButtonsPage> {
  final AuthService _authService = AuthService(); // Create instance here

  List<dynamic> categories = [];
  bool isLoading = true;
  String? _accessToken;
  @override
  void initState() {
    super.initState();
    fetchCategories();
    _loadToken();
  }
  @override


  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');

    if (_accessToken != null) {
      fetchCategories(); // Fetch categories if token is available
    } else {
      // Handle the case where the token is not found (e.g., redirect to login)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://bilalsas.pythonanywhere.com/api/category/'),
        headers: {
          'Authorization': 'Bearer ${widget.token}', // Use widget.token for access
        },
      );

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes); // Decode response body
        final responseData = json.decode(decodedBody); // Parse JSON
        setState(() {
          categories = responseData['results'];
          isLoading = false;
        });
      }  else if (response.statusCode == 401) { // Unauthorized (token expired)
        final newAccessToken = await _authService.refreshToken(context);
        // Call refreshToken from AuthService
        if (newAccessToken != null) {
          // Update widget.token with the new access token
          setState(() {
            widget.token = newAccessToken;
          });
          // Retry the request with the new access token
          return fetchCategories(); // Recursive call
        } else {
          // Handle refresh token failure (e.g., redirect to login)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('حدث خطأ أثناء جلب البيانات. يرجى المحاولة مرة أخرى لاحقًا.'), // Arabic message for other errors
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          return;
        }
      }
      else
      {
        print('Failed to load categories: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نوع الشكاوي'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 2,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cover.png'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          Center(
            child: isLoading
                ? CircularProgressIndicator() // Show loader while fetching
                : categories.isEmpty
                ? Text(
              'No categories found.',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
                :Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two buttons per row
                  crossAxisSpacing: 16, // Space between columns
                  mainAxisSpacing: 16, // Space between rows
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Rounded corners for the card
                    ),
                    elevation: 5, // Shadow for the card
                    color: Colors.white, // Card background color
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Circular button inside the card
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(15), // Padding inside the button
                              backgroundColor: Colors.green[600], // Button color
                              foregroundColor: Colors.white, // Icon color
                            ),
                            onPressed: () {
                              // Handle button click
                              final categoryId = category['id']; // Assuming 'id' key contains the category ID
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(categoryId: categoryId), // Pass categoryId to MainPage
                                ),
                              );
                            },
                            child: Icon(
                              Icons.category, // Example icon
                              color: Colors.white,
                              size: 40, // Icon size
                            ),
                          ),
                          SizedBox(height: 10), // Spacing between button and text
                          Text(
                            category['name'], // Button title
                            style: TextStyle(
                              color: Colors.black, // Title color
                              fontSize: 16, // Title size
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

          ),
        ],
      ),
    );
  }
}
