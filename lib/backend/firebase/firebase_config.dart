import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCy4xXswSJ2opZgK8_Hmtm9qZ_I1WLyUt8",
            authDomain: "sniffsocial.firebaseapp.com",
            projectId: "sniffsocial",
            storageBucket: "sniffsocial.appspot.com",
            messagingSenderId: "768238167223",
            appId: "1:768238167223:web:d2924386412f22e20e9932",
            measurementId: "G-DWSYG7607T"));
  } else {
    await Firebase.initializeApp();
  }
}
