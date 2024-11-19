import 'package:flutter/material.dart';



// class FooterWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       color: Colors.white.withOpacity(0.8), // Adjust background color and opacity
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Image.asset(
//             'assets/images/giz2.png', // Path to your logo
//             width: 90, // Adjust logo size
//           ),
//           SizedBox(width: 10),
//           Expanded( // Wrap Text widget with Expanded
//             child: Text(
//               '',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 1,
//                 fontWeight: FontWeight.bold,
//               ),
//               overflow: TextOverflow.ellipsis, // Prevents overflow by truncating text
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Adjust height as needed
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFC70E0F), Color(0xFF610707)], // The gradient colors
          begin: Alignment.topCenter, // 180 degrees would be top to bottom in Flutter
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the items
        children: [
          // Logo on the left
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/giz-logo2.png', // Make sure to add the logo in your assets folder
              height:70, // Adjust size as needed
            ),
          ),

          // White rectangle with button in the middle
          Align(
            alignment: Alignment.center, // Center the white area
            child: Container(
              width: 200, // Adjust the width of the white container (can be fixed or percentage of screen)
              height: 80, // Set the height of the white container to match the footer height
              decoration: BoxDecoration(
                color: Colors.white, // White background for the area
                borderRadius: BorderRadius.only( // Apply radius only to bottom corners
                  bottomLeft: Radius.elliptical(20,90),
                  bottomRight: Radius.elliptical(20,90),
                ),
              ),
              child: Center( // Center the button vertically
                child: ElevatedButton(
                  onPressed: () {
                    // Button action here
                    print("Button pressed");
                  },
                  child: Text("Click Me"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, // Text color
                    backgroundColor: Colors.transparent, // Transparent background for button
                    elevation: 0, // Remove button shadow
                    side: BorderSide(color: Colors.grey, width: 2), // Gray border for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // Rounded button edges
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Empty space to balance layout
          SizedBox(width: 50),  // Adjust width as needed to maintain balance
        ],
      ),
    );
  }
}


