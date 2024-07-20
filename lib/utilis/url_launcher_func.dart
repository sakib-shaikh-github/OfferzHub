import 'package:flutter/services.dart';
import 'package:offers_hub/utilis/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future launchUrlFunc(String url) async {
  if (url.isEmpty) {
    AppSnackBar.showSnackBar("Offer unreachable😕", colorGreen: false);
  } else {
    try {
      await launchUrl(Uri.parse(url));
    } on PlatformException catch (e) {
      AppSnackBar.showSnackBar(e.message.toString(), colorGreen: false);
    }
  }
}
