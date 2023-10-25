import 'package:flutter/material.dart';

class MyTvPage extends StatelessWidget {
  const MyTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.tv_rounded,
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
