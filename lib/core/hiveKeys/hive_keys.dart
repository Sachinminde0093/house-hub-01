
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferenceKeysProvider = Provider((ref) => PreferenceKeys());

class PreferenceKeys{

  final String accentColor = 'accent_color';

  final String themeMode = 'theme_mode';

  final String welcomePageSeen = 'welcome_page_seen';

  final String customAccent = 'custom_accent';

  final String accessToken = 'access_token';

  final String customAccessToken = 'custom_access_token';
  
  final String customServerURL = 'custom_server_url';

  final String user = 'user';

  final String isLocationScreenShown = 'isLocationScreenShown';

  final String lastKnownLocation = 'lastKnownLocation';

}