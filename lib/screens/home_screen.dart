import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flashcard_controller.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/flashcard_form.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FlashcardController c = Get.put(FlashcardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(
          child: Text(
            'Flashcard Quiz',
            style: TextStyle(fontFamily: 'FontMain',fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor:Colors.white ,
        foregroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height *0.9,
          color: const Color.fromARGB(255, 214, 127, 191),
          child: Obx(() {
            // overlay with progress indicator during DB ops
            return Stack(
              alignment: Alignment.center,
              children: [
                if (c.flashcards.isEmpty)
                  const Text('No flashcards found.',style: TextStyle(fontFamily: 'FontMain'),)
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                         width: MediaQuery.of(context).size.width * 0.45,
                       decoration: BoxDecoration( 
                           borderRadius: BorderRadius.circular(20),
                          //  color: Colors.red,
                         image: DecorationImage(image: AssetImage("images/UnicornCartoon.jpg",
                        ) )
                       ),
                       
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: FlashcardWidget(flashcard: c.current!),
                      ),
                      Container(
                        height: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: c.prev,
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: c.next,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (c.isBusy.value)
                  Container(
                    color: Colors.white.withOpacity(0.4),
                    child:  Center(child: CircularProgressIndicator()),
                  ),
              ],
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed:
            () => showDialog(
              context: context,
              builder:
                  (_) =>
                      FlashcardForm(onSubmit: (q, a) => c.addFlashcard(q, a)),
            ),
      ),
    );
  }
}
