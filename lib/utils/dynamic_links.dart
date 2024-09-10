import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkProvider {
  Future<Uri?> generateDynamicLink(String movieId) async {
    try {
      final dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: 'https://yourapp.page.link',
        link: Uri.parse('https://yourapp.page.link/movie_details?id=$movieId'),
        androidParameters: AndroidParameters(
          packageName: 'com.example.moviesandtv_flutter',
        ),
      );

      final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
      );

      return dynamicLink.shortUrl;
    } catch (e) {
      print('Error generating dynamic link: $e');
      return null;
    }
  }
}
