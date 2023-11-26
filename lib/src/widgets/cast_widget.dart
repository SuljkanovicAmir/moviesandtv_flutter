import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final String mediaType;
  final String movieId;
  final Future<Map<String, dynamic>?> fetchCast;

  const ExpandableContainer(this.mediaType, this.movieId, this.fetchCast,
      {super.key});
  @override
  State<ExpandableContainer> createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: widget.fetchCast,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Cast is not available.');
          } else {
            Map<String, dynamic>? castData = snapshot.data;
            final data = castData?['cast'];

            if (data.isNotEmpty) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: toggleExpansion,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      color: const Color.fromARGB(0, 255, 255, 255),
                      child: Row(
                        children: [
                          const Text(
                            'Cast & Crew',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          const Spacer(),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                      clipBehavior: Clip.antiAlias,
                      duration: const Duration(milliseconds: 200),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color.fromARGB(22, 153, 153, 153),
                      ),
                      height: isExpanded ? 370.0 : 0.0,
                      margin: const EdgeInsets.only(
                          bottom: 20, right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          if (data != null && index < data.length) {
                            final character = data[index];
                            return ListTile(
                              visualDensity:
                                  const VisualDensity(vertical: -4.0),
                              title: Container(
                                padding: const EdgeInsets.all(0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${character['original_name']}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                fontSize: 12.3,
                                                color: Color(0xFFB4B4B4)),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${character['character']}',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                                fontSize: 12.3,
                                                color: Color(0xFFB4B4B4)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const ListTile(
                              visualDensity: VisualDensity(vertical: -4.0),
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Actor',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFFB4B4B4)),
                                      ),
                                      Text(
                                        'Character',
                                        style: TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFFB4B4B4)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      )),
                ],
              );
            } else {
              return Container();
            }
          }
        });
  }
}
