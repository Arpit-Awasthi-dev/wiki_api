class AppConfig {
  final String appTitle;
  final String apiBaseURL;

  /// Get the singleton instance of the class
  static AppConfig? get instance => _instance;

  /// Store the instance of the class to ensure only one instance is created
  static AppConfig? _instance;

  /// private internal constructor to ensure the class can only be instantiated using factory constructor
  AppConfig._internal(
    this.appTitle,
    this.apiBaseURL,
  );

  /// Factory constructor to create a production instance of the class
  factory AppConfig({
    String appTitle = 'Wiki Test',
    String baseUrl = 'en.wikipedia.org',
  }) {
    _instance = _instance ?? AppConfig._internal(appTitle, baseUrl);
    return _instance!;
  }
}
