import 'package:flutter/material.dart';
import 'package:flutter_shared_prefs/page/home/home_screen.dart';
import 'package:flutter_shared_prefs/page/sign_in/sign_in_page.dart';
import 'package:flutter_shared_prefs/page/sign_up/sign_up_page.dart';
import 'package:flutter_shared_prefs/utils/prefs/prefs.dart';
/*
Created by Axmadjon Isaqov on 14:55:46 19.08.2022
© 2022 @axi_dev 
*/

/*
Mavzu:::Shared Preferences
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/sign_in': (context) => const SignInPage(),
        '/sign_up': (context) => const SignUPPage()
      },
      home: FutureBuilder(
          future: Prefs.loadData<String>(key: 'token'),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return const HomeScreen();
            }
            return const SignInPage();
          }),
      // home: const SplashPage(),
    );
  }
}
