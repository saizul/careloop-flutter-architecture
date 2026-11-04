enum AppEnvironment {
  development,
  staging,
  production,
}

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.enableAnalytics,
  });

  final AppEnvironment environment;
  final String appName;
  final bool enableAnalytics;

  static const current = AppConfig(
    environment: AppEnvironment.development,
    appName: 'CareLoop',
    enableAnalytics: false,
  );
}
