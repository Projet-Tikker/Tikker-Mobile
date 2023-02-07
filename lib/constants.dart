import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

const kPrimaryColor = Color(0xFFF0C808);
const kSecondaryColor = Color(0xFF19CBFC);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color.fromARGB(255, 252, 44, 44);
const kValideColor = Color.fromARGB(255, 53, 196, 25);

const kDefaultPadding = 20.0;
bool connected = false;

String email = "Default Email";
String nom = "Default Nom";
String prenom = "Default Prenom";
String pseudo = "Default Pseudo";
String desc = "Default Description";

bool visible = false;
bool visible2 = false;
bool visible3 = true;
String AccountStatut = "Connecté en tant qu'Invité";
final auth = FirebaseAuth.instance;

String ConvId = "";
