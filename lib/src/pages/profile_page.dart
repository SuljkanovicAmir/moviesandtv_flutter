import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/favorites_page.dart';
import 'package:moviesandtv_flutter/src/pages/watchlist_page.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/edit_button.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool content = true;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    print(content);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.sizeOf(context).width,
          constraints:
              BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.network(
                        user?.photoURL ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 106,
                      height: 106,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                user?.displayName ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              const EditButton(),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      content = true;
                    }),
                    child: Text(
                      'Watched',
                      style: TextStyle(
                          fontWeight:
                              content ? FontWeight.w900 : FontWeight.w100,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      content = false;
                    }),
                    child: Text(
                      'Watchlist',
                      style: TextStyle(
                          fontWeight:
                              content ? FontWeight.w100 : FontWeight.w900,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Color.fromARGB(146, 255, 255, 255),
              ),
              if (content == true)
                const MyFavoritesPage()
              else
                const MyWatchlistPage()
            ],
          ),
        )));
  }
}
