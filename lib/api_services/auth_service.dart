import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// AuthService class
class AuthService {
  final String baseUrl = 'https://bilalsas.pythonanywhere.com/user/signup/';

// Method for sending OTP
  Future<Map<String, dynamic>> sendOtp({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('https://bilalsas.pythonanywhere.com/user/send/otp/'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('OTP sent successfully: $responseData'); // Debugging line
      return responseData;
    } else {
      print('Failed to send OTP: ${response.body}'); // Debugging line
      throw Exception('Failed to send OTP: ${response.body}');
    }
  }

// Sign-Up Method (Updated)
  Future<Map<String, dynamic>> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String nationalIdNumber,
    BuildContext? context,
  }) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'full_name': fullName,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'national_id_number': nationalIdNumber,
      }),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);

// Automatically send OTP after successful registration
      try {
        await sendOtp(email: email);
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up successful! OTP sent to your email.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up successful, but failed to send OTP.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }

      return responseData;
    } else if (response.statusCode == 400) {
      final responseData = jsonDecode(response.body);
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account already registered with this email.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      throw Exception('Account already exists');
    } else {
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up failed. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

// refresh token--------------------------------------------------

  Future<String?> refreshToken(BuildContext context)  async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) {
      return null; // Handle refresh token not found
    }

    final response = await http.post(
      Uri.parse('https://bilalsas.pythonanywhere.com/user/token/refresh/'), // Correct endpoint URL
      body: {'refresh': refreshToken},
    );

    if (response.statusCode == 200) {

      final responseData = json.decode(response.body);
      final newAccessToken = responseData['access']; // Assuming 'access' key in response
      await prefs.setString('access_token', newAccessToken);
      return newAccessToken;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء تحديث الرمز المميز. يرجى تسجيل الدخول مرة أخرى.'), // Arabic error message
        ),
      );
      // Handle refresh token error (e.g., invalid refresh token)
      return null;
    }
  }


}

