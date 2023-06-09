import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @preResolve
  Future<FirebaseApp> get firebase => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
