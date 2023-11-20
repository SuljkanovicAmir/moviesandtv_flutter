import 'package:flutter/material.dart';

class GenreButtons extends StatefulWidget {
  final Map<String, String> genres;
  final String contentType;
  final Function(String, String) onGenreSelected;

  const GenreButtons(this.genres, this.contentType, this.onGenreSelected,
      {super.key});

  @override
  State<GenreButtons> createState() => _GenreButtonsState();
}

class _GenreButtonsState extends State<GenreButtons> {
  int selectedGenreIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        itemBuilder: (BuildContext context, int index) {
          String genre = widget.genres.keys.elementAt(index);
          String value = widget.genres.values.elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedGenreIndex = index;
                });
                widget.onGenreSelected(genre, value);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0)),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(
                          255, 255, 255, 255); // Change color when pressed
                    }
                    return selectedGenreIndex == index
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : Colors.transparent;
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return selectedGenreIndex == index
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 255, 255, 255);
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: const BorderSide(
                        color:
                            Color.fromARGB(68, 255, 255, 255)), // Border color
                  ),
                ),
              ),
              child: Text(genre),
            ),
          );
        },
      ),
    );
  }
}
