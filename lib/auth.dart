import 'package:flutter/material.dart';
import 'package:flutter_2fa/flutter_2fa.dart';

class auth extends StatefulWidget {
  const auth({super.key});

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color for the entire page
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Handle 2FA activation
                    await Flutter2FA().activate(
                      context: context,
                      appName: "Flutter 2FA",
                      email: "hipheckt@xyz.com",
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Change color if needed
                  ),
                  child: const Text('Activate 2FA'),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    // Handle 2FA verification
                    await Flutter2FA().verify(
                      context: context,
                      page: const Success(), // Ensure Success is a valid page
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Change color if needed
                  ),
                  child: const Text('Login with 2FA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("user logged In Successfully!")),
    );
  }
}