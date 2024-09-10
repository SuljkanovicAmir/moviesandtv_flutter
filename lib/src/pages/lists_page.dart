import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/create_list_page.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(10, 233, 233, 233),
        title: const Text(
          'Amir\'s Lists',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(),
          Stack(
            children: [
              Positioned(
                bottom: 25,
                right: 25,
                child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateListPage()),
                      );
                    },
                    child: const Icon(Icons.add)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
