import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget pickerDialog(context, controller) {
  var ListTitle = [
    "Camera",
    "Gallerie",
    "Annuler",
  ];
  var icons = [
    Icons.camera_alt_outlined,
    Icons.photo_size_select_actual_outlined,
    Icons.cancel_outlined,
  ];
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      padding: EdgeInsets.all(10),
      color: kPrimaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Sources",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
          Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              3,
              (index) => ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.back();
                      controller.pickImage(context, ImageSource.camera);
                      break;
                    case 1:
                      Get.back();
                      controller.pickImage(context, ImageSource.gallery);
                      break;
                    case 2:
                      Get.back();
                      break;
                    default:
                  }
                },
                leading: Icon(
                  icons[index],
                  color: Colors.white,
                  size: 25,
                ),
                title: Text(
                  ListTitle[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
