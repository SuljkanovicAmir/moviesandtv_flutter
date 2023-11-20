import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/login_page.dart';
import 'package:moviesandtv_flutter/src/pages/movies_page.dart';
import 'package:moviesandtv_flutter/src/pages/tv_page.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;

    late final signOut =
        Provider.of<UserProvider>(context, listen: false).signOutUser;

    void signOutGoogle() async {
      signOut();
      Navigator.pushNamed(context, '/', arguments: {});
    }

    return Drawer(
      backgroundColor: Colors.black,
      elevation: 20,
      width: MediaQuery.of(context).size.width / 1.7,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: const EdgeInsets.all(0.0),
            decoration: const BoxDecoration(color: Colors.black),
            accountName: Text(
              user?.displayName ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, height: 4),
            ),
            accountEmail: const Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: user != null
                  ? Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Image.network(user.photoURL ?? ''))
                  : const Icon(Icons.person),
            ),
          ),
          ListTile(
            textColor: Colors.white,
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/', arguments: {});
            },
          ),
          ListTile(
            textColor: Colors.white,
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyMoviesPages()),
              );
            },
          ),
          ListTile(
            textColor: const Color.fromARGB(255, 255, 255, 255),
            leading: const Icon(Icons.tv),
            title: const Text('Series'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyTvPage()),
              );
            },
          ),
          const Divider(),
          user != null
              ? ListTile(
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Sign Out'),
                  onTap: () {
                    signOutGoogle();
                  },
                )
              : ListTile(
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                  leading: const Icon(Icons.login_outlined),
                  title: const Text('Sign In'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
