import 'package:flutter/material.dart';
import 'package:work_project/splash.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
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
              Text(
                'نبذة عنا',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent, // Adjust color as needed
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                 ' تطبيق ويب وجوال، لإدارة شكاوى المياه في العراق'
                  'مبادرة لبناء التواصل المباشر بين المواطن والحكومة',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black, // Adjust color as needed
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 70), // Add spacing above the button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplashPage()),
                  );
                },
                child: Text('رجوع',
                style: TextStyle(fontSize: 18,
                color: Colors.black,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}