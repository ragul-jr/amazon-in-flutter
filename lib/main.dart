import 'package:tshorts/layout/screen_layout.dart';
import 'package:tshorts/model/product_model.dart';
import 'package:tshorts/providers/user_details_provider.dart';
import 'package:tshorts/screens/product_screen.dart';
import 'package:tshorts/screens/results_screen.dart';
import 'package:tshorts/screens/sell_screen.dart';
import 'package:tshorts/screens/sign_in_screen.dart';
import 'package:tshorts/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
  apiKey: "AIzaSyBK2Yid7wQUaDvwVjeux9sxL_6m-hMfuIU",
  authDomain: "tshorts-401b2.firebaseapp.com",
  projectId: "tshorts-401b2",
  storageBucket: "tshorts-401b2.appspot.com",
  messagingSenderId: "905379250965",
  appId: "1:905379250965:web:b3315a47fbd39825875f1c",
  measurementId: "G-LS7D77H9TF"
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "T Shorts",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
                
              } else if (user.hasData) {
                return const ScreenLayout();
                //return const SellScreen();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}