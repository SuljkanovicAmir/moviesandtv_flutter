import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:moviesandtv_flutter/src/providers/favorites_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatefulWidget {
  final String movieId;
  final String mediaType;
  const FavoriteButton(this.mediaType, {required this.movieId, Key? key})
      : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late String uid;
  late CollectionReference usersCollection;
  late CollectionReference favoritesCollection;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    uid = user?.uid ?? '';
    usersCollection = FirebaseFirestore.instance.collection('users');
    favoritesCollection = FirebaseFirestore.instance.collection('favorites');
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if (snapshot.hasError) {
            // Handle any errors that occurred during the Stream execution
            return Text('Error: ${snapshot.error}');
          }
          // Extract data from the DocumentSnapshot
          Map<String, dynamic>? data =
              snapshot.data?.data() as Map<String, dynamic>?;

          List<dynamic> currentFavorites = data?['favorites'] ?? [];

          bool isMovieInFavorites = false;

          for (var item in currentFavorites) {
            if (item['movieId'] == widget.movieId) {
              isMovieInFavorites = true;
              break;
            }
          }

          return Container(
            width: 80,
            child: Center(
              child: Column(
                children: [
                  GestureDetector(
                    child: Icon(
                      isMovieInFavorites
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined,
                      color: isMovieInFavorites
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 109, 0, 0),
                      size: 40,
                    ),
                    onTap: () {
                      toggleFavoriteStatus(isMovieInFavorites, widget.movieId,
                          widget.mediaType, uid);
                    },
                  ),
                  Text(
                    isMovieInFavorites ? 'Watched' : 'Watch',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // Handle the case when the user is not logged in

      return Container(
        width: 80,
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                child: Icon(
                  Icons.remove_red_eye_outlined,
                  color: const Color.fromARGB(255, 109, 0, 0),
                  size: 40,
                ),
                onTap: () {
                  showToast('You are not Signed In',
                      textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
                      context: context,
                      animation: StyledToastAnimation.fade,
                      reverseAnimation: StyledToastAnimation.fade,
                      position: StyledToastPosition.top,
                      animDuration: const Duration(seconds: 1),
                      duration: const Duration(seconds: 4),
                      curve: Curves.easeInOut,
                      reverseCurve: Curves.linear,
                      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                      textPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ));
                },
              ),
              Text(
                'Watch',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }
  }

  void toggleFavoriteStatus(
      bool isFavorite, String movieId, String mediaType, String uid) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    final favoriteProvider = context.read<FavoritesProvider>();

    if (user != null) {
      if (isFavorite) {
        await usersCollection.doc(uid).update({
          'favorites': FieldValue.arrayRemove([
            {
              'movieId': movieId,
              'mediaType': mediaType,
            }
          ]),
        });
        // ignore: use_build_context_synchronously
        showToast('Removed from Watched',
            textStyle:
                const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            context: context,
            animation: StyledToastAnimation.fade,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.top,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            reverseCurve: Curves.linear,
            backgroundColor: const Color(0xDC7E0707),
            textPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ));
      } else {
        await usersCollection.doc(uid).update({
          'favorites': FieldValue.arrayUnion([
            {
              'movieId': movieId,
              'mediaType': mediaType,
            }
          ]),
        });
        // ignore: use_build_context_synchronously
        showToast('Added to Watched',
            textStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            context: context,
            animation: StyledToastAnimation.fade,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.top,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            reverseCurve: Curves.linear,
            backgroundColor: const Color.fromARGB(255, 226, 226, 226),
            textPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ));
      }
      await favoriteProvider.getFavoriteContent(uid);
    }
  }
}
