import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/data/model/saved_text/saved_text_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreTextsService {
  static const _collection = 'words';
  static const _isLearnedField = 'isLearned';
  static const _creationDateField = 'creationDate';
  static const _originalTextField = 'originalText';

  final FirebaseFirestore _firestore;

  FirestoreTextsService(this._firestore);

  Future<SavedTextResponse> save(SavedTextResponse text) => _firestore
      .collection(_collection)
      .add(text.toJson())
      .then((document) => text.copyWith(id: document.id));

  Future<SavedTextResponse?> getByOriginalText(String originalText) => _firestore
          .collection(_collection)
          .where(_originalTextField, isEqualTo: originalText)
          .limit(1)
          .get()
          .then((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return _parseSavedText(snapshot.docs.first);
        }
      });

  Future<List<SavedTextResponse>> getTextsToLearn() =>
      _getTexts(isLearned: false);

  Future<List<SavedTextResponse>> getLearnedTexts() =>
      _getTexts(isLearned: true);

  Future<List<SavedTextResponse>> _getTexts({
    required bool isLearned,
  }) =>
      _firestore
          .collection(_collection)
          .where(_isLearnedField, isEqualTo: isLearned)
          .orderBy(_creationDateField, descending: true)
          .get()
          .then((snapshot) =>
              snapshot.docs.map((doc) => _parseSavedText(doc)).toList());

  SavedTextResponse _parseSavedText(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return SavedTextResponse.fromJsonFirestore(
      id: doc.id,
      json: doc.data(),
    );
  }

  Future<SavedTextResponse> update(SavedTextResponse text) => _firestore
      .collection(_collection)
      .doc(text.id)
      .update(text.toJson())
      .then((_) => text);

  Future<void> delete(String id) =>
      _firestore.collection(_collection).doc(id).delete();
}
