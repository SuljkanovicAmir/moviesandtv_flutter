import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:moviesandtv_flutter/src/services/auth.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  User? user;

  void submitLogin() {
    signInWithGoogle(context).then((user) {
      if (user != null) {
        Navigator.pushNamed(context, '/',
            arguments: {'user': user, 'signOut': signOut});
        showToast('Welcome ${user.displayName}!',
            textStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            context: context,
            animation: StyledToastAnimation.fade,
            reverseAnimation: StyledToastAnimation.fade,
            position: StyledToastPosition.top,
            animDuration: const Duration(seconds: 1),
            duration: const Duration(seconds: 4),
            curve: Curves.easeInOut,
            reverseCurve: Curves.linear,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            textPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            borderRadius: const BorderRadius.all(
              Radius.circular(20.0),
            ));
      } else {
        print("Sign-in with Google failed");
      }
    });
  }

  Widget googleLoginButton() {
    return OutlinedButton(
      onPressed: () => submitLogin(),
      child: const Text(
        'Sign in with Google',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(bottom: 100),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/google.png',
            width: 200,
            height: 200,
          ),
          googleLoginButton(),
        ],
      ),
    );
  }
}
