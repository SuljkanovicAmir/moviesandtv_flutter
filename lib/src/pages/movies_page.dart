import 'package:flutter/material.dart';

class MyMoviesPages extends StatelessWidget {
  const MyMoviesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_creation_outlined,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Coming Soon',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}
