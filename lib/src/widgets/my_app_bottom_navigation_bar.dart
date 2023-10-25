import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/home_page.dart';
import 'package:moviesandtv_flutter/src/pages/movies_page.dart';
import 'package:moviesandtv_flutter/src/pages/search_page.dart';
import 'package:moviesandtv_flutter/src/pages/tv_page.dart';
import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:provider/provider.dart';

class MyAppBottomNavigationBar extends StatefulWidget {
  final SearchProvider searchProvider;

  const MyAppBottomNavigationBar(this.searchProvider, {Key? key})
      : super(key: key);

  @override
  _MyAppBottomNavigationBarState createState() =>
      _MyAppBottomNavigationBarState();
}

class _MyAppBottomNavigationBarState extends State<MyAppBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();

    final List<Widget> children = [
      const MyHomePage(),
      const MyMoviesPages(),
      const MyTvPage(),
      const MyHomePage(),
      MySearchPage(searchProvider),
    ];

    return Scaffold(
      extendBody: true,
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        unselectedItemColor: const Color.fromARGB(255, 172, 171, 171),
        backgroundColor: const Color.fromARGB(166, 41, 41, 41),
        iconSize: 30.0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedIconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
        ],
      ),
    );
  }
}
