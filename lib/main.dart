import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app_clone/Data/hiveboxs.dart';
import 'package:movie_app_clone/Screens/Home/HomeScreen.dart';
import 'package:movie_app_clone/Screens/Login-Register/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');
  // userBox.put("isUserLogin", false);

  if(userBox.isEmpty){
    userBox.put("isUserLogin", false);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home' : (context) => const HomeScreen(),
        '/login' :(context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  hiveboxs.userBox.get('isUserLogin') ? HomeScreen() : LoginScreen(),
    );
  }
}
