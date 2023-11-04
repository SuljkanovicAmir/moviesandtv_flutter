import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/providers/details_provider.dart';
import 'package:moviesandtv_flutter/src/widgets/details_widget.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String mediaType;
  final String movieId;
  final DetailsProvider detailsProvider;

  const DetailsPage(this.mediaType, this.movieId, this.detailsProvider,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final detailsProvider = context.read<DetailsProvider>();
    Future<Map<String, dynamic>?> fetchDetails =
        detailsProvider.fetchDetails(mediaType, movieId);
    print('detailsmedia $mediaType');
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
              MyDetailsWidget(mediaType, fetchDetails, movieId),
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
