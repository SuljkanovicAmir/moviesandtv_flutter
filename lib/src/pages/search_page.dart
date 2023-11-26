import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/search_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/appBar_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/drawer_widget.dart';
import 'package:moviesandtv_flutter/src/widgets/popular_movies_widget.dart';
import 'package:provider/provider.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

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
    final data = searchProvider.searchData;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
            AppBarWidget(_scaffoldKey),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 71, 71, 71),
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: TextField(
                onChanged: (query) {
                  EasyDebounce.debounce(
                    'searchDebounce',
                    const Duration(milliseconds: 500),
                    () {
                      if (query.isEmpty) {
                        searchProvider.clearDetails();
                      } else {
                        searchProvider.getSearch(query);
                      }
                    },
                  );
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
            if (data!.isNotEmpty)
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  childAspectRatio: 0.7,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  children: List<Widget>.generate(
                    data.length,
                    (index) {
                      final content = data[index];
                      final posterPath = content.posterPath;
                      if (posterPath.isNotEmpty) {
                        return GestureDetector(
                            onTap: () {
                              final movieId = content.id;
                              String mediaType = '';
                              if (content.title.isNotEmpty) {
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
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiConstants.BASE_IMAGE_URL}$posterPath',
                                  width: double.infinity,
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context, url) => Center(
                                    child: Container(
                                      color:
                                          const Color.fromARGB(133, 49, 49, 49),
                                    ),
                                  ),
                                )));
                      }
                      return Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                      );
                    },
                  ),
                ),
              )
            else
              SizedBox(
                height: MediaQuery.of(context).size.height < 500
                    ? MediaQuery.of(context).size.height - 180
                    : null,
                child: const SingleChildScrollView(
                  child: PopularMoviesWidget(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
