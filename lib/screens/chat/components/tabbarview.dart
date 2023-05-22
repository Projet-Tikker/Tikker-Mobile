import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:tikker/screens/chat/components/status.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:velocity_x/velocity_x.dart';

DatabaseReference ref = FirebaseDatabase.instance.ref("Chat");

Future GetAllData() async {
  List table = [];
  Query query = ref.orderByKey().limitToFirst(5);
  query.get().then((snapshot) {
    for (final convs in snapshot.children) {
      table.add(
        {
          "User 1": "${convs.key}",
          "User 2": "${convs.child("Nom").value}",
          "Date": "${convs.child("Description").value}",
          "Msg": "${convs.child("Croissance").value}",
        },
      );
    }
    print(table);
  }, onError: (error) {
    print(error);
  });
}

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
                    ConvId = FirebaseDatabase.instance
                        .ref("Chat/")
                        .push()
                        .key
                        .toString();
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
