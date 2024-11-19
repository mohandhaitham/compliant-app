import 'package:permission_handler/permission_handler.dart';

Future<void> _requestPermissions() async {
  // Request permission for storage
  var status = await Permission.storage.request();
  if (status.isGranted) {
    print("Storage permission granted.");
  } else {
    print("Storage permission denied.");
  }
}
