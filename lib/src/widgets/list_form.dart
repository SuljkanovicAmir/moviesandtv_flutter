import 'package:flutter/material.dart';

class ListForm extends StatefulWidget {
  late TextEditingController myController;
  late TextEditingController descriptionController;

  ListForm(this.myController, this.descriptionController, {Key? key})
      : super(key: key);

  @override
  State<ListForm> createState() => _ListFormState();
}

class _ListFormState extends State<ListForm> {
  @override
  void dispose() {
    widget.myController.dispose();
    widget.descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextFormField(
              onChanged: (query) {},
              controller: widget.myController,
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'List name',
                contentPadding: EdgeInsets.all(10),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 210, 210, 210),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              onChanged: (query) {},
              controller: widget.descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Add description',
                contentPadding: EdgeInsets.all(10),
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 210, 210, 210),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
