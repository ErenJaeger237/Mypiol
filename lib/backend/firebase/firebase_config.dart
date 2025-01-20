import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBYZDEbdHNq71RLtHX07L-TkUdflpY6C10",
            authDomain: "my-piol-cedckq.firebaseapp.com",
            projectId: "my-piol-cedckq",
            storageBucket: "my-piol-cedckq.firebasestorage.app",
            messagingSenderId: "254084640633",
            appId: "1:254084640633:web:0f93a21918c7510cb589a8",
            measurementId: "G-TQTPVF7PTP"));
  } else {
    await Firebase.initializeApp();
  }
}
