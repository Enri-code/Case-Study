class AppUrls {
  static const _base = 'https://reqres.in/';

  static Uri apiWith(String link) => Uri.parse(_base + 'api/$link');
}
