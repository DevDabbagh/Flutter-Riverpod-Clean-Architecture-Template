class Constants {
  static const int receiveTimeout = 30000;
  static const Duration connectionTimeout = Duration(seconds: 30);

  static const baseUrl =
      'https://jsonplaceholder.typicode.com'; // Using placeholder for demo
  // static const baseUrl = 'https://kuphub.net/api'; // Reference URL

  static const USER_DATA = "USER_DATA";
  static const USER_AUTH_TOKEN = "AUTH_TOKEN";
  static const USER_IS_LOGIN = "IS_LOGIN";
  static const APPLICATION_LOCALE = "APPLICATION_LOCALE";
  static const NOTIFIACTION_TOGGLE = "NOTIFIACTION_TOGGLE";
}

class ApiEndPoints {
  static const baseUrl = Constants.baseUrl;

  /// Posts
  static const posts = '/posts';
  static const upload = '/upload'; // Fictional endpoint for demo
}
