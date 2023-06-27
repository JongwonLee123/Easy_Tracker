import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Tracker"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
      ),
      body: Center(
        child: TextButton(
          onPressed: null,
          child: Text("Middle Text"),
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 20),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.lightBlue[800],
        child: Text("Button"),
      ),
    );
  }
}

