// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//putting the firebase collection named ubixstar in data variable
//is to access documents easily
CollectionReference data = FirebaseFirestore.instance.collection('ubixstar');

Future<void> updateData({required String text, required String imageUrl}) {
  //updateFiredata is Map of data fields which are stored in document like Assignment
  Map<String, dynamic> updateFiredata = {};
//first field in map
  updateFiredata['text'] = text;
//second field in map
  updateFiredata['image'] = imageUrl;
  //updating the data fields in Assignment doc
  return data
      .doc('Assignment')
      .update(updateFiredata)
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

//uploadImage is to convert the image in File format to String url

Future<String> uploadImage(File imageFile) async {
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName.jpg');

    // Upload the image to Firebase Storage
    await storageReference.putFile(imageFile);

    // Get the download URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();
    print('Image uploaded successfully. URL: $imageUrl');

    return imageUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return '';
  }
}
