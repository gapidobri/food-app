import 'package:flutter_riverpod/flutter_riverpod.dart';

class Config {
  final String apiUrl;

  const Config({required this.apiUrl});
}

final configProvider = Provider<Config>(
  (ref) => const Config(
    apiUrl: 'https://food-app.gapi.me',
  ),
);
