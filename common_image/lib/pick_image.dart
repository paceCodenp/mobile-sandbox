import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImage extends StatefulWidget {
  final Widget? widgetNeed;
  const PickImage({super.key, this.widgetNeed});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        if (kDebugMode) {
          print('Access Denied');
        }
        // ignore: use_build_context_synchronously
        showAlertDialog(context);
      } else {
        if (kDebugMode) {
          print('Exception occured!');
        }
      }
    }
  }

  showAlertDialog(context) => showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => openAppSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        if (kDebugMode) {
          print('Access Denied');
        }
        // ignore: use_build_context_synchronously
        showAlertDialog(context);
      } else {
        if (kDebugMode) {
          print('Exception occured!');
        }
      }
    }
  }

  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextButton(
              onPressed: showOptions,
              child: widget.widgetNeed ?? const Icon(Icons.camera_alt_outlined),
            ),
            Center(
              child: _image == null
                  ? const Text('No Image selected')
                  : Image.file(_image!),
            ),
          ],
        ),
      ),
    );
  }
}
