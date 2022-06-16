import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Helpers {
  static launchUrl(url) async {
    try {
      await launchUrlString(url);
    } on Exception catch (e) {
      var log = Logger();
      log.wtf(e);
      //developer.log('log me', name: 'testinglog');
    }
  }
}
