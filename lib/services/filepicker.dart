import 'package:file_picker/file_picker.dart';

Future<String?> pickAndAttachFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // You can restrict to specific file types
    );

    if (result != null && result.files.single.path != null) {
      return result.files.single.path; // Return the file path
    } else {
      // User canceled the picker
      return null;
    }
  } catch (e) {
    print("Error picking file: $e");
    return null;
  }
}
