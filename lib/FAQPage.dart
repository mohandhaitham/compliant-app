import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "How do I file a complaint?",
      "answer": "You can file a complaint through the complaint form in the app."
    },
    {
      "question": "What is the estimated response time?",
      "answer": "Our team usually responds within 24 hours."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
        backgroundColor: Colors.green, // Green AppBar background
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: faqs.map((faq) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
            child: ExpansionTile(
              title: Text(
                faq['question'] ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800], // Green text color for question
                ),
              ),
              iconColor: Colors.green, // Green color for expand/collapse icon
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq['answer'] ?? "",
                    style: TextStyle(color: Colors.grey[700]), // Grey text for the answer
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
