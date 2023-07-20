import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfileImagePage extends StatefulWidget {
  @override
  _EditProfileImagePageState createState() => _EditProfileImagePageState();
}

class _EditProfileImagePageState extends State<EditProfileImagePage> {
  File? _selectedImage;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final savedImage = await saveImage(imageFile);

      setState(() {
        _selectedImage = savedImage;
      });
    }
  }

  Future<File> saveImage(File imageFile) async {
    final directory = await getTemporaryDirectory();
    final fileName = 'profile_image.png'; // You can use a custom filename here
    final savedImagePath = '${directory.path}/$fileName';

    final savedImage = await imageFile.copy(savedImagePath);
    return File(savedImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                width: 200,
                height: 200,
              )
            else
              Icon(
                Icons.image,
                size: 100,
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }
}