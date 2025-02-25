import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSite(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    appLogger('No se puedo abrir $url');
  }
}
