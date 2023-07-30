import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/themes.dart';

enum EditFieldType {
  Password,
  Username,
}

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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: fgWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: bodyNumSmall, // Apply the text style for the TextField
                    onChanged: (value) {
                      newValue = value;
                    },
                    decoration: InputDecoration(
                      labelText: fieldType == EditFieldType.Password ? "New Password" : "New Username",
                    ),
                  ),
                  if (fieldType == EditFieldType.Password) SizedBox(height: 16),
                  TextField(
                    style: bodyNumSmall, // Apply the text style for the TextField
                    onChanged: (value) {
                      confirmationValue = value;
                    },
                    decoration: InputDecoration(
                      labelText: fieldType == EditFieldType.Password
                          ? "Confirm Password"
                          : "Confirm Username",
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: btnGreenTheme, // Apply the button style
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
                          Navigator.pop(context); // Close the EditNamePage and navigate back to the profile page
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Passwords do not match."),
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
                        Navigator.pop(context); // Close the EditNamePage and navigate back to the profile page
                      }
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
