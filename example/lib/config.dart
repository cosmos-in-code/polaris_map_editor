/// Configuration for the example app.
class Config {
  /// The Google Places API key for Android.
  static String? googlePlaceAndroidKey =
      const bool.hasEnvironment('GOOGLE_PLACE_ANDROID_KEY')
          ? const String.fromEnvironment('GOOGLE_PLACE_ANDROID_KEY')
          : null;

  /// The Google Places API key for iOS.
  static String? googlePlaceIosKey =
      const bool.hasEnvironment('GOOGLE_PLACE_IOS_KEY')
          ? const String.fromEnvironment('GOOGLE_PLACE_IOS_KEY')
          : null;
}
