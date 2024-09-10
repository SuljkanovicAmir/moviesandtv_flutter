import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/src/widgets/favorites_button.dart';
import 'package:moviesandtv_flutter/src/widgets/watchlist_button.dart';

class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget(
      {Key? key,
      required this.name,
      required this.mediaType,
      required this.movieId,
      required this.runtime})
      : super(key: key);
  final String name;
  final String runtime;
  final String movieId;
  final String mediaType;

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 25,
          right: 25,
          child: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              onPressed: () {
                showModalBottomSheet(
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) =>
                        buildSheet(MediaQuery.of(context).size.height));
              },
              child: const Icon(Icons.add)),
        ),
      ],
    );
  }

  Widget buildSheet(double screenHeight) {
    final double fontSize = screenHeight < 380 ? 14 : 18;
    final double titleFontSize = screenHeight < 380 ? 18 : 24;

    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      decoration: const BoxDecoration(
          color: Color.fromARGB(0, 172, 172, 172),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: titleFontSize,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(180, 0, 0, 0),
                ),
              )),
          const Divider(),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FavoriteButton(movieId: widget.movieId, widget.mediaType),
                WatchlistButton(movieId: widget.movieId, widget.mediaType),
              ],
            ),
          ),
          const Divider(),
          SizedBox(
            height: 26,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.add_rounded),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Review',
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.post_add_rounded),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Add to lists',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.open_in_full_rounded),
              const SizedBox(
                width: 10,
              ),
              Text(
                'View poster',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.share),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Share',
                style: TextStyle(fontSize: fontSize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/*

  if (isMenuOpen)
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.30,
                color: Color.fromARGB(113, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isMenuOpen = false;
                      menuHeight = 0.0;
                    });
                  },
                ),
              )),





                child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: menuHeight,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  )),
              width: MediaQuery.of(context).size.width,
              child: Container(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 18,
                        width: 50,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(0, 145, 145, 145),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/hor.svg',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Flexible(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(180, 0, 0, 0),
                                  ),
                                )),
                            const Divider(),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 50,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                    Text(
                                      'Watch',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 50,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                    Text(
                                      'Watchlist',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.add_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Review',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.post_add_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add to lists',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.open_in_full_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'View poster',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const Divider(),
                            const Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.share),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  )),
            ),
          ),
        ),

              */