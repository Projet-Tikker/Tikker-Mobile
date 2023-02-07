import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:tikker/screens/chat/profil/profile.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

final drawerIconsList = <IconData>[
  Icons.key_rounded,
  Icons.people,
  Icons.notifications_rounded,
  Icons.help,
];

final drawerListTitles = [
  "Compte",
  "Amis",
  "Notifications",
  "Aide",
];

Widget drawer(context) {
  return Drawer(
    backgroundColor: kSecondaryColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          ListTile(
            onTap: (() {
              Get.back();
            }),
            leading: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            title: Text(
              "Paramètres",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          20.heightBox,
          CircleAvatar(
            radius: 45,
            backgroundColor: kPrimaryColor,
            child: Image.asset('assets/icons/user-default.png'),
          ),
          10.heightBox,
          Text(
            "Pseudo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          20.heightBox,
          Divider(
            color: Colors.black,
            height: 1.2,
          ),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
              drawerIconsList.length,
              (index) => ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(
                        () => const ProfileScreen(),
                      );
                      break;
                  }
                },
                leading: Icon(
                  drawerIconsList[index],
                  color: Colors.white,
                ),
                title: Text(
                  "${drawerListTitles[index]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          10.heightBox,
          Divider(
            color: Colors.black,
            height: 1.2,
          ),
          10.heightBox,
          ListTile(
            leading: const Icon(Icons.emoji_people_rounded),
            iconColor: Colors.white,
            title: Text(
              "Inviter un Ami",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Spacer(),
          ListTile(
            onTap: (() {
              Navigator.pushNamed(context, 'home');
            }),
            leading: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: Text(
              "Acceuil",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
