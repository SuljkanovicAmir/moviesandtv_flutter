import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/details_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/details_widget.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String mediaType;
  final String movieId;
  final DetailsProvider detailsProvider;

  const DetailsPage(this.mediaType, this.movieId, this.detailsProvider,
      {super.key});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<Map<String, dynamic>?> fetchDetails;
  late Future<Map<String, dynamic>?> fetchVideo;

  @override
  void initState() {
    super.initState();

    fetchDetails =
        widget.detailsProvider.fetchDetails(widget.mediaType, widget.movieId);
  }

  @override
  void dispose() {
    // Dispose of any resources if necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<DetailsProvider>(context);

    if (detailsProvider.movieDetails.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final details = detailsProvider.movieDetails;
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF000000),
                    Color(0xFF000000),
                    Color(0xFF041125),
                    Color(0xFF061525),
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                MyDetailsWidget(widget.mediaType, details, widget.movieId),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  iconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Text(
                          'HBO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  centerTitle: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
