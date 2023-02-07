import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:tikker/screens/chat/components/status.dart';
import 'package:velocity_x/velocity_x.dart';

Widget tabbarView() {
  return Container(
    child: Expanded(
      child: TabBarView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'message');
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: kPrimaryColor,
                    child: Image.asset('assets/icons/user-default.png'),
                  ),
                  title: "Un Mec".text.size(16).semiBold.make(),
                  subtitle: "Message : ...".text.make(),
                  trailing: "Last Seen".text.gray400.make(),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Status(),
          ),
          Container(
            color: Colors.yellow,
          ),
        ],
      ),
    ),
  );
}
