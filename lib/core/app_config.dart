/// App-wide configuration values that can be overridden at build/run time
/// using `--dart-define`, without hardcoding URLs in the service files.
///
/// Example:
///   flutter run --dart-define=API_BASE_URL=http://192.168.29.158:3000/api
///   flutter build web --dart-define=API_BASE_URL=https://your-app.vercel.app/api
class AppConfig {
  /// Base URL for our own price-comparison backend (the /api folder deployed
  /// to Vercel, or run locally via `npm run dev`).
  ///
  /// Defaults to the deployed production API so a plain `flutter build web`
  /// (no dart-define) still points somewhere real. Override for local dev.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://ai-price-comparision.vercel.app/api',
  );

  /// Image proxy base, used by product_header.dart to avoid hotlinking /
  /// CORS issues when displaying store thumbnails. Configurable for the
  /// same reason as apiBaseUrl.
  static const String imageProxyBaseUrl = String.fromEnvironment(
    'IMAGE_PROXY_BASE_URL',
    defaultValue: 'https://images.weserv.nl/?url=',
  );
}
