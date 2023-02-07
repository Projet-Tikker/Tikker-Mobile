import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GestureDetector(
        onTap: (() {
          key.currentState!.openDrawer();
        }),
        child: Container(
          decoration: const BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
          height: 80,
          width: 100,
          child: const Icon(
            Icons.settings_rounded,
            size: 30,
          ),
        ),
      ),
      Image.asset(
        'assets/images/LogoTikker.png',
        height: 60,
      ),
      Padding(
        padding: EdgeInsets.only(right: 20),
        child: IconButton(
          icon: Icon(Icons.account_circle_outlined),
          iconSize: 30,
          onPressed: () => print("TKT"),
        ),
      ),
    ],
  );
}
