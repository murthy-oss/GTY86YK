// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubixstar_assignment_app/homePage.dart';

class AddWidgetPage extends StatefulWidget {
  const AddWidgetPage({super.key});

  @override
  State<AddWidgetPage> createState() => _AddWidgetPageState();
}

class _AddWidgetPageState extends State<AddWidgetPage> {
  //3 variable to decide which is visible, which is not initially false
  bool Addimage = false;
  bool AddText = false;
  bool SaveButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 750.h,
          width: double.infinity,
          color: const Color.fromARGB(255, 201, 249, 215),
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              // widgetOptions is a method to show our 3 opytions in a ui
              widgetOptions(AddText, 'Text Widget', () {
                setState(() {
                  //to select and unselect TextBox Option
                  AddText = !AddText;
                });
              }),
              SizedBox(
                height: 70.h,
              ),
              widgetOptions(Addimage, 'Image Widget', () {
                setState(() {
                  //to select and unselect ImageBox Option
                  Addimage = !Addimage;
                });
              }),
              SizedBox(
                height: 70.h,
              ),
              widgetOptions(SaveButton, 'Button Widget', () {
                setState(() {
                  //to select and unselect SavedButton Option
                  SaveButton = !SaveButton;
                });
              }),
              SizedBox(
                height: 120.h,
              ),
              //it re-Navigate to HomePage with 3 bools AddText,Addimage,SaveButton
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent, // Background color
                      side: const BorderSide(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(AddText, Addimage, SaveButton)));
                  },
                  child: const Text(
                    "Import Widgets",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

//widgetOptions is a method to show our 3 opytions in a ui
  Widget widgetOptions(bool onoff, String text, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[300], border: Border.all(color: Colors.black12)),
      height: 50.h,
      width: 280.w,
      child: Row(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(30.r),
                child: Container(
                  decoration: BoxDecoration(
                    color: onoff ? Colors.greenAccent : Colors.grey[300],
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
