import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardForm extends StatefulWidget {
  final Flashcard? flashcard;
  final void Function(String question, String answer) onSubmit;

  FlashcardForm({this.flashcard, required this.onSubmit});

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.flashcard?.question ?? '',);
    _answerController =
        TextEditingController(text: widget.flashcard?.answer ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 249, 237, 167),
      title: Text(widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard',style: TextStyle(fontFamily: 'FontMain',color: Colors.purpleAccent),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question',labelStyle: TextStyle(fontFamily: 'FontMain',color: Colors.purpleAccent),),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a question' : null,
            ),
            TextFormField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer',labelStyle: TextStyle(fontFamily: 'FontMain',color: Colors.purpleAccent)),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter an answer' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel',style: TextStyle(fontFamily: 'FontMain',color: Colors.purpleAccent),)),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(
                _questionController.text,
                _answerController.text,
              );
              Navigator.pop(context);
            }
          },
          child: Text('Save',style: TextStyle(fontFamily: 'FontMain',color: Colors.purpleAccent)),
        )
      ],
    );
  }
}
