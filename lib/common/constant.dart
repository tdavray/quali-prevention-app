class AppConstants {
  static const String clientId = "2";
  static const String clientSecret = "MqV2aVyxPulL1dPSmLsq10uXs1wNzwvm13eIXGoU";
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://crm.quali-prevention.fr',
  );
}
