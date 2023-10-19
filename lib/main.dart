import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/pages/auth/login_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId)
    );
  }
  else {
    await Firebase.initializeApp();
    }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;



getUserLoggedInStatus() async {
  await HelperFunction.getUserLoggedInStatus().then((value) {
    if(value != null){
      setState(() {
        _isSignedIn = true;
      });

    }
  } );
}
@override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home: _isSignedIn? const HomePage() : const LoginPage(),
    );
  }
}
