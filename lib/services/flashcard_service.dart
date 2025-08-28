import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard.dart';

class FlashcardService {
  final _collection = FirebaseFirestore.instance.collection('flashcards');

  Stream<List<Flashcard>> getFlashcards() {
    return _collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Flashcard.fromMap(doc.id, doc.data()))
        .toList());
  }

  Future<void> addFlashcard(Flashcard flashcard) async {
    await _collection.add(flashcard.toMap());
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    await _collection.doc(flashcard.id).update(flashcard.toMap());
  }

  Future<void> deleteFlashcard(String id) async {
    await _collection.doc(id).delete();
  }
}

