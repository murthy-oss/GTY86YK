// ignore_for_file: file_names, non_constant_identifier_names, avoid_print, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubixstar_assignment_app/AddwidgetPage.dart';
import 'package:ubixstar_assignment_app/functions/firebaseupdate.dart';

class HomePage extends StatefulWidget {
  //3 variable to decide which is visible, which is not

  //TextBox
  final bool addText;
  //ImageBox
  final bool addimage;
  //Saved Button
  final bool saveButton;
  const HomePage(this.addText, this.addimage, this.saveButton, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //variable to store gallery or camera image in File format
  File? galleryFile;
  //picker is to pick an image from Gallery or camera
  final picker = ImagePicker();
  //_controller is to access and  control the TextField value which is entered by the user
  TextEditingController _controller = TextEditingController();
  //elementnotselected used in the of checking the any widget is selected or not
  bool elementnotselected = false;

  @override
  Widget build(BuildContext context) {
    //re-initializing  3 widget
    bool AddText = widget.addText;
    bool Addimage = widget.addimage;
    bool SaveButton = widget.saveButton;
    return Scaffold(
        //SingleChildScrollView is to avoid the render size errors while accessing the TextField's keyboard
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            //Title of the app
            Text(
              "Assignment App",
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30.h,
            ),
            //light-green container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: const Color.fromARGB(255, 201, 249, 215),
              ),
              height: 500.h,
              width: 300.w,
              child:
                  //below are the possible cases about user selecting widgets

                  //3 widgets are selected (TextBox,ImageBox,SavedButton)
                  (AddText && Addimage && SaveButton)
                      ? Column(
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            //TextBox function
                            TextBox(),
                            //ImageBox funtion
                            uploagimage(),
                            const SizedBox(
                              height: 40,
                            ),
                            //Saved Button funtion
                            saveButton(Addimage, AddText, SaveButton, context,
                                galleryFile)
                          ],
                        )
                      //only ImageBox and SavedButton widgets are selected by user case
                      : (!AddText && Addimage && SaveButton)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                //ImageBox function
                                uploagimage(),
                                const SizedBox(
                                  height: 40,
                                ),
                                //savedButton function
                                saveButton(Addimage, AddText, SaveButton,
                                    context, galleryFile)
                              ],
                              //only TextBox and SavedButton widgets are selected by user case
                            )
                          : (AddText && !Addimage && SaveButton)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    //TextBox function
                                    TextBox(),

                                    const SizedBox(
                                      height: 40,
                                    ),
                                    //SavedButton function
                                    saveButton(Addimage, AddText, SaveButton,
                                        context, galleryFile = File(''))
                                  ],
                                  //only SavedButton widget is selected by user case
                                )
                              : (!AddText && !Addimage && SaveButton)
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        //elementnotselected is true when the savedButton is clicked if not i provide a space above button
                                        (elementnotselected)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 150.h),
                                                child: Text(
                                                  "Add at-least a\nwidget to save",
                                                  style: TextStyle(
                                                      fontSize: 25.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            : SizedBox(
                                                height: 340.h,
                                              ),
                                        //savedButton function
                                        saveButton(Addimage, AddText,
                                            SaveButton, context, galleryFile)
                                      ],
                                    )
                                  :
                                  //if any one of the widgets are not selected
                                  dafaultText(),
            ),
            SizedBox(
              height: 20.h,
            ),
            //this Button Navigates to AddWidgetPage which show the 3widget to choose
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Background color
                    side: const BorderSide(color: Colors.black)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddWidgetPage()));
                },
                child: Text(
                  "Add Widgets",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ))
          ],
        ),
      ),
    ));
  }

//if any one of the widgets are not selected
  Widget dafaultText() {
    return Center(
      child: Text(
        "No Widget is added",
        style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

//TextBox Function
  Widget TextBox() {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: TextField(
        //to access the value entered by the user
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Enter Text',
          hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          filled: true,
          fillColor: Colors.grey[300],
        ),
      ),
    );
  }

  //SavedButton Function
  Widget saveButton(bool Addimage, bool AddText, bool SaveButton,
      BuildContext context, File? galleryFile) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
            backgroundColor: Colors.greenAccent, // Background color
            side: const BorderSide(
              color: Colors.black,
            )),
        onPressed: () {
          setState(() {
            //if any one of the TextBox or ImageBox is true or both  along with SavedButton always true
            //then only we will get a chance to store the data in database
            if ((Addimage || AddText) && SaveButton) {
              print(_controller.text);
              print(galleryFile);
              //uploadImage is to convert the image in File format to String url
              //updateData is to update the data in database
              uploadImage(galleryFile!).then((imageUrl) {
                updateData(text: _controller.text, imageUrl: imageUrl);
              });

              //SnackBar is confirm whether the is Saved Successfully or not
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.greenAccent,
                  content: Center(
                      child: Text(
                    "Successfully Saved",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              );
            }
            //  if not any one of the TextBox or ImageBox is true or both  along with SavedButton always true
            //then we use elementnotselected to show some text like "Add at-least one element"
            else {
              elementnotselected = !elementnotselected;
            }
          });
        },
        child: const Text(
          "Save",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ));
  }

//ImageBox function
  Widget uploagimage() {
    return GestureDetector(
      onTap: () {
        print("gallery");
        _showPicker(context: context);
      },
      child: Container(
        height: 200.h,
        width: 260.w,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: galleryFile == null
            ? const Center(
                child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ))
            : Center(child: Image.file(galleryFile!)),
      ),
    );
  }

  //_showPicker is show the "Gallery and camera tab" to select
  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  //access from gallery
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  //access from camera
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //to get the image from gallery or camera
  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
