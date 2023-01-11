import 'package:flutter/material.dart';
import 'package:tikker/home.dart';
import 'package:tikker/theme.dart';
import 'package:tikker/screens/chats/chats_screen.dart';
import 'package:tikker/login.dart';
import 'package:tikker/register.dart';
import 'package:tikker/account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tikker/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
      routes: {
        'home': (context) => MyHome(),
        /*'search': (context) => ,
        'post': (context) => ,*/
        'account': (context) => MyAccount(),
        'chat': (context) => ChatsScreen(),
        'login': (context) => MyLogin(),
        'auth': (context) => MyAuth(),
        'register': (context) => MyRegister(),
      },
    );
  }
}
