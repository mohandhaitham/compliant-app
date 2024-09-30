import 'package:flutter/material.dart';

class TrainingProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample training programs data with different icons
    final List<Map<String, dynamic>> programs = [
      {
        "title": "Communication And ICT",
        "description":
        "The group offers professional training programs in telecommunications, including modern communication generations, to reach the trainee with the highest skills required in the labor market.",
        "icon": Icons.chat,
      },
      {
        "title": "Programming & Microsoft Training",
        "description": "The group offers professional training programs in the field of computer software.",
        "icon": Icons.mobile_friendly,
      },
      {
        "title": "Data Science",
        "description": "Analyze and interpret complex data.",
        "icon": Icons.analytics,
      },
      {
        "title": "Graphic Design",
        "description": "Design stunning graphics and layouts.",
        "icon": Icons.design_services,
      },
      {
        "title": "Digital Marketing",
        "description": "Master the art of online marketing.",
        "icon": Icons.safety_check,
      },
      {
        "title": "Cyber Security",
        "description": "Protect your information online.",
        "icon": Icons.security,
      },
      {
        "title": "Project Management",
        "description": "Learn to manage projects efficiently.",
        "icon": Icons.business_center,
      },
      {
        "title": "Artificial Intelligence",
        "description": "Dive into the world of AI and machine learning.",
        "icon": Icons.computer,
      },
      {
        "title": "Cloud Computing",
        "description": "Explore cloud services and solutions.",
        "icon": Icons.cloud,
      },
      {
        "title": "Networking",
        "description": "Understand the principles of networking.",
        "icon": Icons.network_check,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Training Programs"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Number of columns
            childAspectRatio: 1.8, // Aspect ratio for each card
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
          ),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Define what happens when the card is clicked
                  print("${programs[index]['title']} clicked");
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        programs[index]['icon'], // Dynamic icon loading
                        size: 40,
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
                      Text(
                        programs[index]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        programs[index]['description'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
