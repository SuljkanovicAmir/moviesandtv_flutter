import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviesandtv_flutter/utils/api_constants.dart';

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
            return Container(
              height: 190,
              color: const Color.fromARGB(0, 255, 255, 255),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('Cast is not available.');
          } else {
            Map<String, dynamic>? castData = snapshot.data;
            final data = castData?['cast'];

            if (data.isNotEmpty) {
              return Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 15),
                      child: const Text(
                        'Cast',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    Container(
                        height: 180,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: ListView.builder(
                            itemCount: 8,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (data != null && index < data.length) {
                                final character = data[index];

                                return GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 15),
                                          clipBehavior: Clip.hardEdge,
                                          decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle),
                                          child: character['profile_path'] !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      '${ApiConstants.BASE_IMAGE_CAST_URL}${character['profile_path']}',
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Container(
                                                      color:
                                                          const Color.fromARGB(
                                                              132, 88, 88, 88),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : const Icon(
                                                  Icons.not_interested_sharp,
                                                  size: 100,
                                                  color: Color.fromARGB(
                                                      255, 90, 90, 90),
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 115,
                                          child: Text(
                                            '${character['original_name']}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        SizedBox(
                                          width: 115,
                                          child: Text(
                                            '${character['character']}',
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Color(0xFFB4B4B4)),
                                          ),
                                        ),
                                      ],
                                    ));
                              } else {
                                return Container(height: 180);
                              }
                            })),
                  ],
                ),
              );
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: const Text(
                        'Cast',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: const SelectableText(
                        'No cast details',
                        style: TextStyle(
                            color: Color.fromARGB(230, 255, 255, 255)),
                      ),
                    ),
                  ]);
            }
          }
        });
  }
}



/* 

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

                              */