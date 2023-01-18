import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tikker/constants.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  // Text Controlleurs
  final Email = TextEditingController();
  final PassWord = TextEditingController();
  final Nom = TextEditingController();
  final Prenom = TextEditingController();

  Color color = kErrorColor;
  bool visible = false;
  String _errorMessage = '';

  Future SendUser() async {
    try {
      if (Email.text.isEmpty || PassWord.text.isEmpty) {
        print("Veuillez Remplir tous les Champs");
        setState(() {
          _errorMessage = "Veuillez Remplir tous les Champs";
          visible = true;
          color = color;
        });
      } else {
        CreateUser();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future CreateUser() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text, password: PassWord.text);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email.text, password: PassWord.text);
    AddUser();
  }

  Future AddUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print(Email.text);
    print(PassWord.text);
    print(Nom.text);
    print(Prenom.text);
    await FirebaseDatabase.instance.ref("users/" + uid).set(
      {
        'Email': Email.text,
        'PassWord': PassWord.text,
        'Nom': Nom.text,
        'Prenom': Prenom.text,
      },
    );
    await FirebaseDatabase.instance
        .ref("users/" + uid + Email.text)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        print("Compte Déjà Existant !!");
        setState(() {
          _errorMessage = "Compte Déjà Existant !!";
          visible = true;
          color = Color.fromARGB(255, 202, 32, 20);
        });
      } else {
        FirebaseDatabase.instance.ref("users/" + uid).get().then((snapshot) {
          if (snapshot.exists) {
            print("Inscription Effectué !!");
            setState(() {
              _errorMessage = "Inscription Effectué !!";
              visible = true;
              color = Colors.green;
            });
            setState(() {
              connected = true;
              AccountStatut = "Connecté";
            });
            print(AccountStatut);
            print(connected);
            Navigator.pushNamed(context, 'home');
          } else {
            print("Aucune Données n'a été transmises !!");
            setState(() {
              _errorMessage = "Aucune Données n'a été transmises !!";
              visible = true;
              color = Color.fromARGB(255, 202, 32, 20);
            });
          }
          FirebaseAuth.instance.signOut();
        });
      }
    });
  }

  @override
  void dispose() {
    Email.dispose();
    PassWord.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height *
                      0.1, // 20% de la hauteur
                  left: MediaQuery.of(context).size.width *
                      0.1), // 10% de la largeur
              child: Text(
                'Inscrivez-Vous',
                style: GoogleFonts.cinzel(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height *
                        0.3), // 30% de la hauteur
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width *
                              0.05, // 5% de la largeur
                          left: MediaQuery.of(context).size.width *
                              0.05), // 5% de la largeur
                      child: Column(
                        children: [
                          TextField(
                            controller: Email,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.poppins(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              ValidateEmail(value);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: PassWord,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(),
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: Nom,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Nom",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: Prenom,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Prenom",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      SendUser;
                                      CreateUser;
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Enregistrement',
                                            ),
                                            Icon(Icons.save_outlined)
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: Container(
                                      child: Text(
                                        "Déjà un compte ?",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Visibility(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _errorMessage,
                                style: TextStyle(color: color),
                              ),
                            ),
                            visible: visible,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: color),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void ValidateEmail(String val) {
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }
}
