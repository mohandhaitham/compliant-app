

import 'package:image_picker/image_picker.dart';

// ... (other imports)


typedef void OnPhotoAttachedCallback(String? photoPath);

Future<void> openCameraAndAttachPhoto(OnPhotoAttachedCallback onPhotoAttached) async {
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      // Process the captured photo, e.g., upload it or store it
      print('Photo path: ${photo.path}');
      // You can access the photo bytes using photo.readAsBytes()
      // and upload them to your server or store them locally.

      // Call the callback function to update the UI
      onPhotoAttached(photo.path);
    } else {
      // User canceled the camera
      print('User canceled taking a photo.');
    }
  } catch (e) {
    print('Error taking photo: $e');
  }
}