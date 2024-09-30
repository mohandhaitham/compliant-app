import 'package:flutter/material.dart';
import 'package:work_project/userform.dart';
import 'Dashborad.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Sample user data
  String name = "John Doe";
  String email = "johndoe@example.com";
  String phone = "+1 (555) 123-4567";

  // Sample complaint history
  List<Map<String, String>> complaints = [
    {"date": "2023-09-01", "status": "Resolved", "issue": "Late delivery"},
    {"date": "2023-09-10", "status": "Pending", "issue": "Damaged product"}
  ];

  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centered Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_image.png'), // Add your own image path here
              ),
              SizedBox(height: 20),

              // Personal Information Section with modern style
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Personal Information", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => setState(() {
                        name = value;
                      }),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => setState(() {
                        email = value;
                      }),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => setState(() {
                        phone = value;
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Complaint History Section with modern style
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Complaint History", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.report_problem, color: Colors.redAccent),
                            title: Text(complaints[index]['issue']!),
                            subtitle: Text("Status: ${complaints[index]['status']}"),
                            trailing: Text(complaints[index]['date']!),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Settings Section with Switch and Navigation Buttons
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Settings", style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 10),
                    SwitchListTile(
                      title: Text("Enable Notifications"),
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          notificationsEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Navigation to UserForm
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserForm()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("User Form", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),

              SizedBox(height: 15),

              // Navigation to DashboardPage
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("User Dashboard", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
