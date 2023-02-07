import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tikker/constants.dart';
import 'post_widget.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String _errorMessage = '';
  Color color = kErrorColor;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      routage(index);
      _selectedIndex = index;
      print(index);
    });
  }

  Future VerifAccount() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseDatabase.instance
        .ref("users/" + user.uid + "/role")
        .get()
        .then((snapshot) {
      if (snapshot == "client") {
        Navigator.pushNamed(context, 'home');
      } else {
        if (snapshot == "admin") {
          print("Votre Espace D'Administration n'a pas encore été Créé.");
          setState(() {
            _errorMessage =
                "Votre Espace D'Administration n'a pas encore été Créé.";
            color = kErrorColor;
          });
        } else {
          if (snapshot == "comptable") {
            print("Vous n'êtes pas Autorisé à Accéder à cette Application !!");
            setState(() {
              _errorMessage =
                  "Vous n'êtes pas Autorisé à Accéder à cette Application !!";
              color = kErrorColor;
            });
          }
        }
      }
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
      if (index == 2 && _selectedIndex != 2) {
        Navigator.pushNamed(context, 'camera');
      } else {
        if (index == 4 && _selectedIndex != 4) {
          if (FirebaseAuth.instance.currentUser.toString().isEmpty) {
          } else {
            Navigator.pushNamed(context, 'account');
          }
        }
      }
    }
  }

  Future ConnectedOrNot() async {
    print(connected);
    if (connected == true) {
      visible = true;
      visible2 = true;
      AccountStatut = "Connecté" + email;
      visible3 = true;
    } else {
      print("Connecté en tant qu'Invité");
      AccountStatut = "Connecté en tant qu'Invité";
      visible3 = false;
      visible = false;
    }
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
                ConnectedOrNot();
                if (connected == true) {
                  Navigator.pushNamed(context, 'chat');
                } else {
                  Navigator.pushNamed(context, 'login');
                }
              },
              icon: const Icon(
                Icons.send_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AccountStatut,
                  style: TextStyle(color: color),
                ),
              ),
              PostWidget(),
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
