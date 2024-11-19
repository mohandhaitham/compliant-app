import 'package:flutter/material.dart';

import 'about.dart';
import 'complaint_catgory.dart';
import 'login.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cover.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png',
              width: 200,), // Replace with your logo path
              SizedBox(height: 20),
              Text(
                'شكاوي المواطنين',
                style: TextStyle(fontSize: 24, color: Colors.black,
                fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('التسجيل'),
                  ),
                  ElevatedButton(
                    // onPressed: () {
                    //
                    //   // Action for button 2
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => AboutUsPage()),
                    //   );
                    // },
                    onPressed: () {

                      // Action for button 2
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DynamicButtonsPage(token: '',)),
                      );
                    },
                    child: Text('من نحن'),
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