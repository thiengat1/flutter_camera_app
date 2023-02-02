/*
 * @Description: 
 * @Author: Lewis
 * @Date: 2023-02-01 14:06:18
 * @LastEditTime: 2023-02-02 09:38:29
 * @LastEditors: Lewis
 */

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // ignore: prefer_typing_uninitialized_variables
  dynamic _imageFile;

  final ImagePicker _picker = ImagePicker();
  _openGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = photo;
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Make a choice'),
            content: SingleChildScrollView(
              child: ListBody(children: [
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ]),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (_imageFile == null) {
      return const Text('No image selected');
    } else {
      return Image.file(File(_imageFile.path), width: 400, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Main Screen',
          )),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _decideImageView(),
                ElevatedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: const Text("Select Image"))
              ]),
        ),
      ),
    );
  }
}
