import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/favorites_page.dart';
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
  State<MyAppBottomNavigationBar> createState() =>
      _MyAppBottomNavigationBarState();
}

class _MyAppBottomNavigationBarState extends State<MyAppBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();

    final List<Widget> children = [
      MyHomePage(),
      const MyMoviesPages(),
      const MyTvPage(),
      const MyFavoritesPage(),
      MySearchPage(searchProvider),
    ];

    return Scaffold(
      extendBody: true,
      body: children[_currentIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.white,
        height: 60,
        elevation: 3,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: const Color.fromARGB(193, 12, 12, 12),
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (index != 4) {
            searchProvider.clearDetails();
          }
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.movie,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.movie_creation_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.tv,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.tv,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.list_alt,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.list_alt_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
