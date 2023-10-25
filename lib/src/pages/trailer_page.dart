import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyTrailerPage extends StatelessWidget {
  final Future<Map<String, dynamic>?> fetchVideo;

  const MyTrailerPage(this.fetchVideo, {super.key});

  @override
  Widget build(BuildContext context) {
    String key = 'dQw4w9WgXcQ';
    List<dynamic> trailers;
    WebViewController controller;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Trailer',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        body: FutureBuilder<Map<String, dynamic>?>(
            future: fetchVideo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return const Text('Video is not available.');
              } else {
                Map<String, dynamic>? videoData = snapshot.data;
                final data = videoData?['results'];

                if (videoData != null) {
                  if (data.isNotEmpty) {
                    trailers = data
                        .where((video) => video['type'] == 'Trailer')
                        .toList();
                    if (trailers.isNotEmpty) {
                      key = trailers[0]['key'];
                    }
                  }
                }

                controller = WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(
                      Uri.parse('https://www.youtube.com/embed/$key'));

                return Container(
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
                    padding: const EdgeInsets.only(bottom: 400),
                    width: MediaQuery.of(context).size.width,
                    child: WebViewWidget(
                      controller: controller,
                    ));
              }
            }));
  }
}
