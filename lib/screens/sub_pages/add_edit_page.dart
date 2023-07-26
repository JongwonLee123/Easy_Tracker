// 3rd-party Packages
import 'package:easy_tracker/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Local
import 'package:easy_tracker/utils/entry_data.dart';
import 'package:easy_tracker/utils/themes.dart';

// inc is used to control the initial state of radio buttons
// if Add new data, pass in "nullData" as EntryData
// nullData is defined as EntryData(name: null, ...);
// if Edit existing data, pass in EntryData
class AddEditPageArguments {
  bool inc = true;
  late EntryData entryData;

  AddEditPageArguments(bool b, EntryData eD) {
    inc = b;
    entryData = eD;
  }
}

class AddEditPage extends StatefulWidget {
  final AddEditPageArguments addPageArguments;

  const AddEditPage({
    Key? key,
    required this.addPageArguments
  }): super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  late AddEditPageArguments addPageArguments;
  String pageFunction = "Add";

  bool inc = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: pickedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100)
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: pickedDate.hour, minute: pickedDate.minute),
  );

  @override
  void dispose() {
    // Clean up the controllers!!!
    // good practice for some reason I don't know
    nameController.dispose();
    amountController.dispose();
    descController.dispose();
    super.dispose();
  }

  // this function is called when dependencies change
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addPageArguments = ModalRoute.of(context)!.settings.arguments as AddEditPageArguments;

    if (addPageArguments.entryData.name != null) {
      inc = addPageArguments.inc ? true : false;
      EntryData d = addPageArguments.entryData;
      nameController = TextEditingController(text: d.name);
      amountController = TextEditingController(text: d.amount.toString());
      descController = TextEditingController(text: d.description);
      pickedDate = fromSecondsSinceEpoch(d.timestamp);
      pickedTime = TimeOfDay.fromDateTime(pickedDate);
      pageFunction = "Edit";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        EntryData nullData = EntryData(
          id: -1,
          amount: 0,
          timestamp: 0,
        );
        Navigator.pop(context, nullData);
        // For some reason, this needs to return false
        // to "LOCK" the default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$pageFunction Entry",
            style: bodyMedium,
          ),
          backgroundColor: fgWhite,
          leading: BackButton(
            onPressed: () {
              EntryData nullData = EntryData(
                id: -1,
                amount: 0,
                timestamp: 0,
              );
              Navigator.pop(context, nullData);
            },
            color: Colors.black,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "$pageFunction Entry",
                      style: bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: ShapeDecoration(
                      color: fgWhiteTransparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      shadows: const [generalShadow],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // INCOME EXPENSE RADIO INPUT FIELD
                        LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final parentWidth = constraints.maxWidth;
                            return Row(
                              children: [
                                SizedBox(
                                  width: parentWidth * 0.5 - 4,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        inc = true;
                                      });
                                    },
                                    style: inc? btnGreenTheme: btnWhiteTheme,
                                    child: const Text(
                                      "Income",
                                      style: bodyMedium,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SizedBox(
                                  width: parentWidth * 0.5 - 4,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        inc = false;
                                      });
                                    },
                                    style: inc? btnWhiteTheme: btnRedTheme,
                                    child: const Text(
                                      "Expense",
                                      style: bodyMedium,
                                    ),
                                  ),
                                )
                              ]
                            );
                          },
                        ),
                        // NAME INPUT FIELD
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2
                          ),
                          child: Text("Name", style: bodyMedium),
                        ),
                        SizedBox(
                          child: TextField(
                            controller: nameController,
                            decoration: customInputDecoWithHint("Enter Name")
                          )
                        ),
                        // AMOUNT INPUT FIELD
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2
                          ),
                          child: Text("Amount", style: bodyMedium),
                        ),
                        SizedBox(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            decoration: customInputDecoWithHint("Enter Amount")
                          )
                        ),
                        // DATE TIME INPUT FIELD
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2
                          ),
                          child: Text("Date and Time", style: bodyMedium),
                        ),
                        LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            final parentWidth = constraints.maxWidth;
                            return Row(
                              children: [
                                  // DATE LEFT BOX
                                SizedBox(
                                    width: parentWidth * 0.5 - 4,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final newDate = await pickDate();
                                        if (newDate != null) {
                                          setState(() {
                                            pickedDate = newDate;
                                          });
                                        }
                                      },
                                      style: btnWhiteTheme,
                                      child: Text(
                                        DateFormat("MMM dd, yyyy").format(pickedDate),
                                        style: bodyNumMedium,
                                      ),
                                    )
                                ),
                                const SizedBox(width: 8),
                                // TIME RIGHT BOX
                                SizedBox(
                                  width: parentWidth * 0.5 - 4,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final newTime = await pickTime();
                                      if (newTime != null) {
                                        setState(() {
                                          pickedTime = newTime;
                                        });
                                      }
                                    },
                                    style: btnWhiteTheme,
                                    child: Text(
                                      DateFormat("h : mm a").format(
                                        DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute
                                        )
                                      ),
                                      style: bodyNumMedium,
                                    ),
                                  )
                                )
                              ]
                            );
                          },
                        ),
                        // DESCRIPTION INPUT FIELD
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2
                          ),
                          child: Text("Note (optional)", style: bodyMedium),
                        ),
                        SizedBox(
                          child: TextField(
                            controller: descController,
                            decoration: customInputDecoWithHint("Enter Description")
                          )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    width: double.infinity,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          String n = nameController.text;
                          String a = amountController.text;
                          double d = 0.0;
                          try {
                            d = double.parse(a);
                          } on FormatException {
                            d = -1.0;
                          }
                          if (n.isEmpty || a.isEmpty || d < 0.0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => Dialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                elevation: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (n.isEmpty)
                                        const Text(
                                          "Name can't be empty!",
                                          style: bodyMedium
                                        ),
                                      if (a.isEmpty)
                                        const Text(
                                          "Amount can't be empty!",
                                          style: bodyMedium
                                        ),
                                      if (d < 0.0)
                                        const Text(
                                          "Please enter a Positive Amount!",
                                          style: bodyMedium
                                        ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Close',
                                            style: bodySmall
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              )
                            );
                          } else {
                            DateTime t = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute
                            );
                            EntryData returnData = EntryData(
                              id: -1,
                              name: nameController.text.trim(),
                              amount: inc? d: -d,
                              timestamp: secondsSinceEpoch(t),
                              description: descController.text.trim(),
                            );
                            Navigator.pop(context, returnData);
                          }
                        },
                        style: btnWhiteTheme,
                        child: const Text(
                          "Confirm",
                          textAlign: TextAlign.center,
                          style: bodyMedium,
                        ),
                      )
                    )
                  )
                ],
              )
            )
          ),
        )
      ),
    );
  }
}