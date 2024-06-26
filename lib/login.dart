import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tikker/home.dart';
import 'package:tikker/constants.dart';

class MyAuth extends StatefulWidget {
  const MyAuth({Key? key}) : super(key: key);
  @override
  _MyAuthState createState() => _MyAuthState();
}

class _MyAuthState extends State<MyAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('ERRRRRRRRROOOOOOORRRRRR !!!!!!'),
          );
        } else if (snapshot.hasData) {
          return MyHome();
        } else {
          return MyLogin();
        }
      }),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  // Text Controlleurs
  final Email = TextEditingController();
  final PassWord = TextEditingController();

  final auth = FirebaseAuth.instance;

  String _errorMessage = '';
  Color color = kErrorColor;

  Future LoginIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email.text.toString().trim(),
        password: PassWord.text.toString().trim(),
      );
      setState(() {
        connected = true;
        visible = true;
        visible3 = false;
      });
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await FirebaseDatabase.instance
          .ref("users/" + uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          setState(() {
            print(snapshot.child("Email").value.toString());
            email = snapshot.child("Email").value.toString();
            print(snapshot.child("Nom").value.toString());
            nom = snapshot.child("Nom").value.toString();
            print(snapshot.child("Prenom").value.toString());
            prenom = snapshot.child("Prenom").value.toString();
            print(snapshot.child("Pseudo").value.toString());
            pseudo = snapshot.child("Pseudo").value.toString();
            print(snapshot.child("Desc").value.toString());
            desc = snapshot.child("Desc").value.toString();
            AccountStatut = "Connecté en tant que " + pseudo;
          });
        }
      });
      print(connected);
      print(AccountStatut);
      Navigator.pushNamed(context, 'auth');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      setState(() {
        _errorMessage =
            "There is no user record corresponding to this identifier !\nL'Email ou le Mot de Passe est Incorrect !";
      });
    }
  }

  Future LoginAsGuest() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      setState(() {
        connected = false;
        AccountStatut = "Connecté en tant qu'Invité";
        visible = false;
        visible3 = true;
      });
      print(AccountStatut);
      print(connected);
      Navigator.pushNamed(context, 'home');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future Register() async {
    Navigator.pushNamed(context, 'register');
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
                      0.2, // 20% de la hauteur
                  left: MediaQuery.of(context).size.width *
                      0.1), // 10% de la largeur
              child: Text(
                'Welcome\nBack',
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
                        0.5), // 50% de la hauteur
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
                                return "Please Enter Your Email";
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
                            height: 30,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Password";
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
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    LoginIn();
                                  }),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              child: Text(
                                                'Connexion',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5)),
                                            Icon(
                                              Icons.lock_open_outlined,
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
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: Register,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(
                                            "Inscrivez-vous !",
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
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width *
                                  0.17, // 22% de la largeur
                            ),
                            child: Container(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      LoginAsGuest();
                                    }),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                child: Text(
                                                  "Connexion en tant qu'Invité",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              Icon(
                                                Icons.no_accounts_outlined,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
