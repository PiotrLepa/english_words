import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/data/model/saved_text/saved_text_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  static const _wordsCollection = 'words';

  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> saveText(SavedTextResponse text) =>
      _firestore.collection(_wordsCollection).add(text.toJson());

  Future<List<SavedTextResponse>> getSavedTexts() => _firestore
      .collection(_wordsCollection)
      .get()
      .then((snapshot) => snapshot.docs
          .map((doc) => SavedTextResponse.fromJsonFirestore(
                id: doc.id,
                json: doc.data(),
              ))
          .toList());

  dynamic encodeNestedFieldsInJson(Map<String, dynamic> json) =>
      jsonDecode(jsonEncode(json));
}
