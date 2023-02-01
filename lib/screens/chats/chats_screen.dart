import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedIndex = 1;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            backgroundColor: kSecondaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.black,
                  ),
                  title: Text("Setting"),
                ),
                20.heightBox,
                CircleAvatar(
                  radius: 45,
                  backgroundColor: kPrimaryColor,
                  child: Image.asset('assets/icons/user-default.png'),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (() {
                      scaffoldKey.currentState!.openDrawer();
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
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      color: kSecondaryColor,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: TabBar(
                          labelColor: kPrimaryColor,
                          indicatorColor: kPrimaryColor,
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: "Status",
                            ),
                            Tab(
                              text: "Chat",
                            ),
                            Tab(
                              text: "Camera",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: kPrimaryColor,
                                      child: Image.asset(
                                          'assets/icons/user-default.png'),
                                    ),
                                    title:
                                        "Un Mec".text.size(16).semiBold.make(),
                                    subtitle: "Message : ...".text.make(),
                                    trailing: "Last Seen".text.gray400.make(),
                                  );
                                },
                              ),
                            ),
                            Container(
                              color: Colors.green,
                            ),
                            Container(
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            backgroundColor: kPrimaryColor,
          ),
        ),
      ),
    );

    /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 210, 86),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Chat',
            style: TextStyle(color: Colors.black, height: 60),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {}),
          backgroundColor: Color.fromARGB(255, 238, 210, 86),
          child: const Icon(Icons.person_add_alt_1, color: Colors.white),
        ),
        bottomNavigationBar: buildBottomNavigationBar());
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      // type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'People'),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            label: 'Profile'),
      ],
    );*/
  }
}
