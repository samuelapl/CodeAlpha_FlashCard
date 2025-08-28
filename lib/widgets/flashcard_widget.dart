import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/flashcard.dart';
import '../controllers/flashcard_controller.dart';
import 'flashcard_form.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;
  FlashcardWidget({required this.flashcard, super.key});

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool showAnswer = false;
  final FlashcardController c = Get.find<FlashcardController>();

  @override
  Widget build(BuildContext context) {    
    return Card(
      color: showAnswer ? const Color.fromARGB(255, 242, 224, 192) : Colors.cyan.shade100,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showAnswer ? widget.flashcard.answer : widget.flashcard.question,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: 'FontMain',color: Colors.purpleAccent),
            ),
           SizedBox(
           height: MediaQuery.of(context).size.height * 0.01,
           ),
            ElevatedButton(
              onPressed: () => setState(() => showAnswer = !showAnswer),
              child: Text(showAnswer ? 'Hide Answer' : 'Show Answer',style: TextStyle(fontFamily: 'FontMain',fontWeight: FontWeight.w500,color: Colors.purpleAccent,fontSize: 15),),
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // EDIT
                IconButton(
                  tooltip: 'Edit',
                  icon: const Icon(Icons.edit,color: Colors.purpleAccent,),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => FlashcardForm(
                        flashcard: widget.flashcard,
                        onSubmit: (q, a) {
                          c.updateFlashcard(
                            Flashcard(
                              id: widget.flashcard.id,
                              question: q,
                              answer: a,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                // DELETE
                IconButton(
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete,color: Colors.purpleAccent,),
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title:  Text('Delete flashcard?',style: TextStyle(fontFamily: 'FontMain'),),
                        content: Text('This action cannot be undone.',style: TextStyle(fontFamily: 'FontMain'),),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child:Text('Cancel',style: TextStyle(fontFamily: 'FontMain'),),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child:  Text('Delete',style: TextStyle(fontFamily: 'FontMain'),),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await c.deleteFlashcard(widget.flashcard.id);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


