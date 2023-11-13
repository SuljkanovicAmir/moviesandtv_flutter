import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');
final CollectionReference favoritesCollection =
    FirebaseFirestore.instance.collection('favorites');

Future<User?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User? user = authResult.user;
    final User? currentUser = _auth.currentUser;
    print('User signed in: $currentUser');

    setUser(context, user);

    if (user != null && currentUser != null) {
      assert(currentUser.uid == user.uid);
    }

    DocumentSnapshot userDocument = await usersCollection.doc(user?.uid).get();

    if (!userDocument.exists) {
      await usersCollection.doc(user?.uid).set({'favorites': []});
    }

    return user;
  } catch (e) {
    print("Error signing in with Google: $e");
    return null;
  }
}

void signOut() async {
  print('Before sign-out: ${FirebaseAuth.instance.currentUser}');
  await googleSignIn.signOut();
  await FirebaseAuth.instance.signOut();
  print('After sign-out: ${FirebaseAuth.instance.currentUser}');
}

void setUser(BuildContext context, User? user) {
  final UserProvider userProvider =
      Provider.of<UserProvider>(context, listen: false);
  userProvider.setUser(user);
}
