import 'package:flutter/material.dart';
import 'package:easy_tracker/widgets/profile_widget.dart'; // Add this import

class EditNamePage extends StatelessWidget {
  final EditFieldType fieldType;
  final String initialValue;
  final Function(String) onSaveValue;

  EditNamePage({
    Key? key,
    required this.fieldType,
    required this.initialValue,
    required this.onSaveValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newValue = initialValue;
    String confirmationValue = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(fieldType == EditFieldType.Password ? "Edit Password" : "Edit Username"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                newValue = value;
              },
              decoration: InputDecoration(
                labelText: fieldType == EditFieldType.Password ? "New Password" : "New Username",
              ),
            ),
            if (fieldType == EditFieldType.Password)
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  confirmationValue = value;
                },
                decoration: InputDecoration(
                  labelText: "Confirm New Password",
                ),
              ),
            if (fieldType == EditFieldType.Username)
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  confirmationValue = value;
                },
                decoration: InputDecoration(
                  labelText: "Confirm New Username",
                ),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (newValue.trim().isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Please enter a valid value."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                } else if (fieldType == EditFieldType.Password) {
                  if (newValue == confirmationValue) {
                    onSaveValue(newValue);
                    Navigator.pop(context); // Close the EditNamePage
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Do no match."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  onSaveValue(newValue);
                  Navigator.pop(context); // Close the EditNamePage
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
