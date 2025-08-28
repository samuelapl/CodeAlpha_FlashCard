import 'package:get/get.dart';
import '../models/flashcard.dart';
import '../services/flashcard_service.dart';

class FlashcardController extends GetxController {
  final FlashcardService _service = FlashcardService();

  // Observables
  final flashcards = <Flashcard>[].obs;
  final isBusy = false.obs;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _service.getFlashcards().listen((cards) {
      flashcards.assignAll(cards);
      if (flashcards.isEmpty) currentIndex.value = 0;
      else currentIndex.value = currentIndex.value % flashcards.length;
    });
  }

  Flashcard? get current =>
      flashcards.isEmpty ? null : flashcards[currentIndex.value];

  void next() {
    if (flashcards.isEmpty) return;
    currentIndex.value = (currentIndex.value + 1) % flashcards.length;
  }

  void prev() {
    if (flashcards.isEmpty) return;
    currentIndex.value =
        (currentIndex.value - 1 + flashcards.length) % flashcards.length;
  }

  Future<void> addFlashcard(String q, String a) async {
    await _run(
      () => _service.addFlashcard(Flashcard(id: '', question: q, answer: a)),
      onOk: () => Get.snackbar('Success', 'Flashcard added'),
      onErr: () => Get.snackbar('Error', 'Failed to add flashcard'),
    );
  }

  Future<void> updateFlashcard(Flashcard f) async {
    await _run(
      () => _service.updateFlashcard(f),
      onOk: () => Get.snackbar('Updated', 'Flashcard updated'),
      onErr: () => Get.snackbar('Error', 'Failed to update flashcard'),
    );
  }

  Future<void> deleteFlashcard(String id) async {
    await _run(
      () => _service.deleteFlashcard(id),
      onOk: () => Get.snackbar('Deleted', 'Flashcard removed'),
      onErr: () => Get.snackbar('Error', 'Failed to delete flashcard'),
    );
  }

  Future<void> _run(
    Future<void> Function() task, {
    required void Function() onOk,
    required void Function() onErr,
  }) async {
    try {
      isBusy.value = true;
      await task();
      onOk();
    } catch (_) {
      onErr();
    } finally {
      isBusy.value = false;
    }
  }
}


