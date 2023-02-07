import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'components/tabbar.dart';
import 'components/tabbarview.dart';
import 'components/appbar.dart';
import 'components/drawer.dart';

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
          drawer: drawer(context),
          body: Column(
            children: [
              appbar(scaffoldKey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
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
