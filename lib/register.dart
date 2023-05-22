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
  final Pseudo = TextEditingController();
  final Bio = TextEditingController();

  Color color = kErrorColor;
  bool visible = false;
  String _errorMessage = '';
  String _errorMessage1 = '';

  Future SendUser() async {
    try {
      if (Email.text.isEmpty ||
          PassWord.text.isEmpty ||
          Nom.text.isEmpty ||
          Prenom.text.isEmpty ||
          Pseudo.text.isEmpty ||
          Bio.text.isEmpty) {
        print("Veuillez Remplir tous les Champs !!");
        setState(() {
          _errorMessage = "Veuillez Remplir tous les Champs !!";
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
    print(Pseudo.text);
    print(Bio.text);
    await FirebaseDatabase.instance.ref("users/" + uid).set(
      {
        'Email': Email.text,
        'PassWord': PassWord.text,
        'Nom': Nom.text,
        'Prenom': Prenom.text,
        'Pseudo': Pseudo.text,
        'Desc': Bio.text,
      },
    );
    await FirebaseDatabase.instance.ref("users/" + uid).get().then((snapshot) {
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
        print("Aucune Donnée n'a été transmise ! ");
        setState(() {
          _errorMessage = "Aucune Donnée n'a été transmise !";
          visible = true;
          color = Color.fromARGB(255, 202, 32, 20);
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter an Email";
                              }
                              return null;
                            },
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Password";
                              }
                              return null;
                            },
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Name";
                              }
                              return null;
                            },
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Prenom";
                              }
                              return null;
                            },
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
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Pseudo";
                              }
                              return null;
                            },
                            controller: Pseudo,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: false,
                              hintText: "Pseudo",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a Little Description";
                              }
                              return null;
                            },
                            controller: Bio,
                            textInputAction: TextInputAction.done,
                            style: GoogleFonts.poppins(),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (() {
                                        SendUser();
                                      }),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                'Enregistrement',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5)),
                                            Icon(
                                              Icons.save_outlined,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'login');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Text(
                                                "Déjà un compte ?",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                              _errorMessage1,
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
        _errorMessage1 = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage1 = "Invalid Email Address";
      });
    } else {
      setState(() {
        _errorMessage1 = "";
      });
    }
  }
}
