class AppConfig {
  static const APP_ID = '1ee2b126b783a652a096f1b8453f95612';

  static bool isValidEmail(String emailId) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailId);
  }
}
