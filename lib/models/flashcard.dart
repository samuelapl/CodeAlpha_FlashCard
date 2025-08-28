class Flashcard {
  final String id;
  final String question;
  final String answer;

  Flashcard({required this.id, required this.question, required this.answer});

  Map<String, dynamic> toMap() => {
        'question': question,
        'answer': answer,
      };

  static Flashcard fromMap(String id, Map<String, dynamic> data) {
    return Flashcard(
      id: id,
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}

