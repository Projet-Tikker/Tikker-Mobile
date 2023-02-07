import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tikker/screens/chat/components/appbar.dart';
import 'package:tikker/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final msg = TextEditingController();
    String CurrentDate = DateTime.now().hour.toString() +
        "h" +
        DateTime.now().minute.toString() +
        "m" +
        DateTime.now().second.toString() +
        "s";

    Future publishMsg() async {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      String ConvId =
          FirebaseDatabase.instance.ref("Chat/").push().key.toString();
      String MsgId = FirebaseDatabase.instance
          .ref("Chat/" + ConvId + "/" + uid)
          .push()
          .key
          .toString();
      print(uid);
      print(ConvId);
      print(MsgId);
      print(msg.text);
      print(CurrentDate);
      await FirebaseDatabase.instance
          .ref("Chat/" + ConvId + "/" + uid + "/" + MsgId)
          .set(
        {
          'Message': msg.text,
          'Date': CurrentDate,
        },
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_rounded),
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Image.asset('assets/icons/user-default.png'),
                  ),
                  20.widthBox,
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Username\n",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Last Seen",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.more_vert_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Directionality(
                    textDirection:
                        index.isEven ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                index.isEven ? kPrimaryColor : kSecondaryColor,
                            child: Image.asset('assets/icons/user-default.png'),
                          ),
                          20.widthBox,
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? kPrimaryColor
                                    : kSecondaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text("Hello World !!"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              DateTime.now().hour.toString() +
                                  "h" +
                                  DateTime.now().minute.toString() +
                                  "m" +
                                  DateTime.now().second.toString() +
                                  "s",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 50, 50, 50),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: msg,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ecrivez Votre Message ...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  20.widthBox,
                  GestureDetector(
                    onTap: () {
                      print("publish");
                      publishMsg();
                    },
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
