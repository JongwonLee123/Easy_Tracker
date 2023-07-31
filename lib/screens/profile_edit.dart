import 'package:flutter/material.dart';
import 'package:easy_tracker/utils/themes.dart';

enum EditFieldType {
  password,
  username,
}

class EditNamePage extends StatelessWidget {
  final EditFieldType fieldType;
  final String initialValue;
  final Function(String) onSaveValue;

  const EditNamePage({
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
        title: Text(
          fieldType == EditFieldType.password ? "Edit Password" : "Edit Username",
          style: bodyMedium,
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: fgWhite.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: bodySmall, // Apply the text style for the TextField
                    onChanged: (value) {
                      newValue = value;
                    },
                    decoration: InputDecoration(
                      labelText: fieldType == EditFieldType.password ? "New Password" : "New Username",
                    ),
                  ),
                  if (fieldType == EditFieldType.password) const SizedBox(height: 16),
                  TextField(
                    style: bodySmall, // Apply the text style for the TextField
                    onChanged: (value) {
                      confirmationValue = value;
                    },
                    decoration: InputDecoration(
                      labelText: fieldType == EditFieldType.password
                          ? "Confirm Password"
                          : "Confirm Username",
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: btnGreenTheme, // Apply the button style
                    onPressed: () {
                      if (newValue.trim().isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Error",
                                style: bodyMedium,
                              ),
                              content: const Text(
                                "Please enter a valid value.",
                                style: bodySmall,
                              ),
                              actions: [
                                TextButton(
                                  style: btnWhiteTheme,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: bodySmall,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else if(newValue.trim().length > 16 && fieldType == EditFieldType.username){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Error",
                                style: bodyMedium,
                              ),
                              content: const Text(
                                "Username can not be more than 16 characters!",
                                style: bodySmall,
                              ),
                              actions: [
                                TextButton(
                                  style: btnWhiteTheme,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
                                    style: bodySmall,
                                  ),
                                ),
                              ],
                            );
                            },
                        );
                      }
                      else if (fieldType == EditFieldType.password) {
                        if (newValue == confirmationValue) {
                          onSaveValue(newValue);
                          Navigator.pop(context); // Close the EditNamePage and navigate back to the profile page
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Error",
                                  style: bodyMedium,
                                ),
                                content: const Text(
                                  "Passwords do not match.",
                                  style: bodySmall,
                                ),
                                actions: [
                                  TextButton(
                                    style: btnWhiteTheme,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: bodySmall,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      else {
                        if(newValue == confirmationValue){
                          onSaveValue(newValue);
                          Navigator.pop(context);
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Error",
                                  style: bodyMedium,
                                ),
                                content: const Text(
                                  "Usernames do not match",
                                  style: bodySmall,
                                ),
                                actions: [
                                  TextButton(
                                    style: btnWhiteTheme,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: bodySmall,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: bodySmallWhite,
                    ),
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