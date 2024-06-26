import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tikker/constants.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:tikker/screens/chat/profil/components/picker_dialog.dart';
import 'package:tikker/screens/chat/profil/controllers/profile_controller.dart';

final ImagePicker _controller = ImagePicker();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: kPrimaryColor,
              child: Stack(
                children: [
                  //_controller.imgpath.isEmpty ?
                  Image.asset('assets/icons/user-default-connected.png'),
                  Positioned(
                    right: 0,
                    bottom: 20,
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ).onTap(() {
                        Get.dialog(
                          pickerDialog(context, _controller),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            20.heightBox,
            Divider(
              color: Colors.black,
              height: 1.2,
            ),
            10.heightBox,
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Name",
                  ),
                  hintText: pseudo,
                  isDense: true,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Description",
                  ),
                  hintText: desc,
                  isDense: true,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.call,
                color: Colors.white,
              ),
              title: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Téléphone",
                  ),
                  isDense: true,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
