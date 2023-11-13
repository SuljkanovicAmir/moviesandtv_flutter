import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Image.network(user?.photoURL ?? '')),
              const SizedBox(height: 15),
              Text(
                user?.displayName ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ));
  }
}
