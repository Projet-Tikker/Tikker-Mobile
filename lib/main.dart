import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tikker/Gallery.dart';
import 'package:tikker/home.dart';
import 'package:tikker/screens/message/message.dart';
import 'package:tikker/theme.dart';
import 'package:tikker/screens/chat/chats_screen.dart';
import 'package:tikker/login.dart';
import 'package:tikker/register.dart';
import 'package:tikker/account.dart';
import 'package:tikker/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tikker/firebase_options.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final List<CameraDescription> cameras = await availableCameras();
  runApp(
    MyApp(
      cameras: cameras,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.cameras,
  });
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
      routes: {
        'home': (context) => MyHome(),
        /*'search': (context) => ,*/
        'camera': (context) => MyCamera(
              cameras: cameras,
            ),
        'account': (context) => MyAccount(),
        'chat': (context) => ChatsScreen(),
        'message': (context) => MessageScreen(),
        'login': (context) => MyLogin(),
        'auth': (context) => MyAuth(),
        'register': (context) => MyRegister(),
      },
    );
  }
}
