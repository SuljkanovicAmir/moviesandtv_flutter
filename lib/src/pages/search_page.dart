import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/pages/movies_page.dart';
import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/popular_movies_widget.dart';
import 'package:provider/provider.dart';

class MySearchPage extends StatefulWidget {
  final SearchProvider searchProvider;

  const MySearchPage(this.searchProvider, {Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    final data = searchProvider.searchData['results'];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text(
          'HBO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        elevation: 20,
        width: MediaQuery.of(context).size.width / 1.7,
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Amir',
              ),
              accountEmail: Text(''),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              textColor: Colors.white,
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyMoviesPages()),
                );
              },
            ),
            ListTile(
              textColor: Colors.white,
              leading: Icon(Icons.tv),
              title: Text('Series'),
              onTap: () {
                // Handle navigation to the settings page
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color.fromARGB(255, 1, 3, 7),
              Color.fromARGB(255, 3, 10, 20),
              Color.fromARGB(255, 3, 14, 31),
              Color(0xFF041125),
              Color(0xFF041125),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 71, 71, 71),
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: TextField(
                onChanged: (query) {
                  if (query.isEmpty) {
                    searchProvider.clearDetails();
                  } else {
                    searchProvider.fetchSearch(query);
                  }
                },
                controller: myController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  border: InputBorder.none,
                  labelText: 'What are you looking for?',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 134, 134, 134),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (data != null)
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List<Widget>.generate(
                    data.length,
                    (index) {
                      final content = data[index];
                      final posterPath = content['poster_path'];
                      if (posterPath != null) {
                        return GestureDetector(
                          onTap: () {
                            final movieId = content['id'];
                            String mediaType = '';
                            if (content.containsKey('title')) {
                              mediaType = 'movie';
                            } else {
                              mediaType = 'tv';
                            }

                            Navigator.pushNamed(context, '/details',
                                arguments: {
                                  'mediaType': mediaType,
                                  'movieId': movieId,
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 1,
                            ),
                            // Set the desired width as a fraction (50% in this case)
                            child: Image.network(
                                width: double.infinity,
                                'https://image.tmdb.org/t/p/w500/$posterPath',
                                fit: BoxFit.fitHeight),
                          ),
                        );
                      }
                      return Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                      );
                    },
                  ),
                ),
              )
            else
              Container(
                height: MediaQuery.of(context).size.height < 500
                    ? MediaQuery.of(context).size.height - 180
                    : null,
                child: SingleChildScrollView(
                  child: PopularMoviesWidget(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
