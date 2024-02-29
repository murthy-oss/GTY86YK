import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ubixstar_assignment_app/firebase_options.dart';
import 'package:ubixstar_assignment_app/homePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //intially the TextBox,ImageBox and SavedButton is false that means not visible
      home: ScreenUtilInit(
          designSize: Size(392.727, 781.090),
          child: HomePage(false, false, false)),
    );
  }
}
