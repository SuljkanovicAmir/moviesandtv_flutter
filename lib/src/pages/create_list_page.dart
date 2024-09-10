import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/widgets/list_form.dart';

class CreateListPage extends StatelessWidget {
  const CreateListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    final descriptionController = TextEditingController();

    void submitForm() {
      String listName = myController.text;
      String description = descriptionController.text;

      print('hii $listName');
      print(description);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 24, color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text('New List'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 34, 34, 34),
                  actionsPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  titleTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  contentTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 230, 230, 230)),
                  title: const Text('Discard Changes?'),
                  content:
                      const Text('Are you sure you want to discard changes?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        Navigator.of(context).pop(); // Close New List page
                      },
                      child: const Text('Discard',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.check), onPressed: () => submitForm())
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListForm(myController, descriptionController)),
    );
  }
}
