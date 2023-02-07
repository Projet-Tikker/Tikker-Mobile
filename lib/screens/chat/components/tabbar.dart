import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';

Widget tabbar() {
  return Container(
    color: kSecondaryColor,
    child: RotatedBox(
      quarterTurns: 1,
      child: TabBar(
        labelColor: kPrimaryColor,
        indicatorColor: kPrimaryColor,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            text: "Chats",
          ),
          Tab(
            text: "Status",
          ),
          Tab(
            text: "Camera",
          ),
        ],
      ),
    ),
  );
}
