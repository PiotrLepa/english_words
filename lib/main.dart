import 'dart:developer';

import 'package:english_words/tophonetics_ipa_transcription_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Words',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: _buildPhonetic(),
      ),
    );
  }

  Widget _buildPhonetic() {
    return FutureBuilder(
      future: ToPhoneticsIpaTranscriptionProvider().get('think and more\nmore'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(child: Text(snapshot.data.toString()));
        } else if (snapshot.hasError) {
          log(
            'get phonetic error:',
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
          );
          return Text(snapshot.error.toString());
        } else {
          return Text(snapshot.toString());
        }
      },
    );
  }
}
