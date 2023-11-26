import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesandtv_flutter/firebase_options.dart';

import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:moviesandtv_flutter/src/providers/user_provider.dart';
import 'package:moviesandtv_flutter/src/services/firebase_notif.dart';
import 'package:moviesandtv_flutter/utils/provider.setup.dart';
import 'package:moviesandtv_flutter/utils/routes.dart';
import 'package:provider/provider.dart';
import 'src/widgets/my_app_bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotif().initNotification();
  runApp(buildAppProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.initializeUser();

    return MaterialApp(
      title: 'Cineboxd',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.black,
            seedColor: const Color.fromARGB(0, 104, 58, 183)),
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      initialRoute: '/',
      onGenerateRoute: generateRoute,
      home: MyAppBottomNavigationBar(searchProvider),
    );
  }
}
