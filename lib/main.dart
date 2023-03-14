import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/presentation/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencyInjection();
  runApp(App());
}