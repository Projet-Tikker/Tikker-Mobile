import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tikker/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var imgpath = "".obs;
  var imglink = "";

  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();

    var status = await Permission.photos.status;

    if (status.isGranted) {
      try {
        final img = await ImagePicker().pickImage(
          source: source,
          imageQuality: 80,
        );
        imgpath.value = img!.path;
        VxToast.show(context, msg: "Image Selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: "Permission Denied");
    }
  }
}
