
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'consts/consts.dart';
import 'package:firebase_core/firebase_core.dart';

// start app add loader
// make some changes to lazy loading of allproducts at home page
//order_code,order_date_add field doesn't exist needs to be hardcoded instead add
// resolve lazyput error on home page whileredirecting to products

void main()   {

  WidgetsFlutterBinding.ensureInitialized(); // for phone mostly
   // image change not working profile editor

   Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  //  for web mostly
  );

  //  app check whenever needed
  //  FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
  //   androidProvider: AndroidProvider.playIntegrity,
  //    // appleProvider: AppleProvider.appAttest,
  // );

     runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // add get due to getx
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          // to set color of each icon in complete app
            iconTheme: IconThemeData(color: darkFontGrey),
            // set elevation 0
            elevation: 0.0,
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}
