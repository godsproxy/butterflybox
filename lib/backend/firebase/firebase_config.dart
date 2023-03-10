import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAUReWtM9ehJU3mBfbAb23065Phnlig3tY",
            authDomain: "theta-camera-378821.firebaseapp.com",
            projectId: "theta-camera-378821",
            storageBucket: "theta-camera-378821.appspot.com",
            messagingSenderId: "508886444412",
            appId: "1:508886444412:web:a8976a32822cdf74e5dcf9",
            measurementId: "G-S9659ECQCY"));
  } else {
    await Firebase.initializeApp();
  }
}
