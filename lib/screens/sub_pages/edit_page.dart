import 'package:flutter/material.dart';

enum ProfileField {
  username,
  email,
  phoneNumber,
  password,
}

class EditProfilePage extends StatefulWidget {
  final ProfileField fieldToEdit;

  EditProfilePage(this.fieldToEdit);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _textEditingController1 = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  @override
  void dispose() {
    _textEditingController1.dispose();
    _textEditingController2.dispose();
    super.dispose();
  }

  String get fieldName {
    switch (widget.fieldToEdit) {
      case ProfileField.username:
        return 'Username';
      case ProfileField.email:
        return 'Email';
      case ProfileField.phoneNumber:
        return 'Phone Number';
      case ProfileField.password:
        return 'Password';
      default:
        return '';
    }
  }

  void _saveInformation() {
    // Save the information to a file or perform any desired actions here
    String editedValue1 = _textEditingController1.text;
    String editedValue2 = _textEditingController2.text;

    // Display a notification before saving the information
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Save'),
          content: Text('Are you sure you want to save the information?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Perform the actual saving of information here
                // ...

                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Close the edit page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit $fieldName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController1,
              decoration: InputDecoration(
                labelText: 'Enter $fieldName',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _textEditingController2,
              decoration: InputDecoration(
                labelText: 'Confirm $fieldName',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveInformation,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}