import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Gayathri",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple
              ),
              ),
              SizedBox(height: 10,),

              Text("Developer",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              ),
              SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () {},
                child: Text("Like Me"),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}