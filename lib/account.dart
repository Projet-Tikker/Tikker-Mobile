import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  int _selectedIndex = 4;
  void _onItemTapped(int index) {
    setState(() {
      routage(index);
      _selectedIndex = index;
      print(index);
    });
  }

  void routage(int index) {
    if (index == 0 && _selectedIndex != 0) {
      Navigator.pushNamed(context, 'home');
    } else {
      /*if (index == 1 && _selectedIndex != 1) {
        Navigator.pushNamed(context, 'collection');
      } else {
        if (index == 2 && _selectedIndex != 2) {
          Navigator.pushNamed(context, 'add');
        }
      }*/
      if (index == 4 && _selectedIndex != 4) {
        Navigator.pushNamed(context, 'account');
      }
    }
  }

  Future logout() async {
    FirebaseAuth.instance.signOut();
    setState(() {
      connected = false;
    });
    Navigator.pushNamed(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tikker',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            'assets/images/LogoTikker.png',
            height: 60,
          ),
          actions: [
            IconButton(
              onPressed: () {
                logout();
                Navigator.pushNamed(context, 'home');
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Connecté en tant que :',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      pseudo,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bonjour M.",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          nom + " " + prenom,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Votre Email est : ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description :",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      desc,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Color(0xFF4F83BF),
                        ),
                        icon: Icon(
                          Icons.logout_outlined,
                          size: 32,
                        ),
                        label: Text(
                          "Déconnection !",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          auth.signOut();
                          Navigator.pushNamed(context, 'login');
                        },
                      ),
                    ),
                  ],
                ),
                visible: visible,
              ),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        "Vous n'êtes pas connectè. Pour Accéder à cette Page, Veuillez vous connecter !",
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Color(0xFF4F83BF),
                        ),
                        icon: Icon(
                          Icons.logout_outlined,
                          size: 32,
                        ),
                        label: Text(
                          "Connectez-vous !",
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          auth.signOut();
                          Navigator.pushNamed(context, 'login');
                        },
                      ),
                    ],
                  ),
                ),
                visible: visible3,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade700,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined), label: 'Add Photo'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}
