import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'TrainingProgramScreen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> partnerLogos = [
    'assets/images/6B303ADA.jpg', // Replace with actual partner logos
    'assets/images/A213D95E.jpg',
    'assets/images/alhussam.png',
    'assets/images/atria.png',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green[700]!, // Dark green
                  Colors.green[200]!, // Light green
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/ptg.png', // Replace with your logo path
                    width: size.width * 0.4,
                  ),
                  SizedBox(height: 30),

                  // Paragraph text
                  Text(
                    "The Professional Trainers Group offers training and skills development services in various fields. We are committed to providing high-quality training programs that meet the needs of individuals and organizations alike. We work passionately to foster professional and personal growth.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Button
                  MaterialButton(
                    onPressed: () {
                      // Define what happens when the button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TrainingProgramScreen()),
                      );
                    },
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.white,
                    child: Text(
                      "Our Program",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // "Our Partners" Title
                  Text(
                    "Our Partners",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Carousel Slider for partners' logos
                  CarouselSlider(
                    options: CarouselOptions(
                      height: size.height * 0.15,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: partnerLogos.map((logo) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: size.width * 0.6,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              logo,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
