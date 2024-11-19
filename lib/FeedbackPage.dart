import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Experience",
        style: TextStyle(  color: Colors.white,),),
        backgroundColor: Colors.green, // AppBar background color set to green
        centerTitle: true, // Center the title for a cleaner look
        elevation: 0, // Remove shadow for a flatter design
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How would you rate our service?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
            SizedBox(height: 16),
            Center(
              child: RatingWidget(), // Rating widget is centered for better alignment
            ),
            SizedBox(height: 24),
            Text(
              "Your Feedback",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green[700]),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tell us about your experience",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                filled: true,
                fillColor: Colors.grey[200], // Light background for the input field
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle submit action
                },
                child: Text(
                  "Submit Feedback",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatefulWidget {
  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          iconSize: 32, // Increase icon size for better visibility
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
        );
      }),
    );
  }
}
