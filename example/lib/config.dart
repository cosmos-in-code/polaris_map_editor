class Config {
  static String? googlePlaceAndroidKey =
      const bool.hasEnvironment('GOOGLE_PLACE_ANDROID_KEY')
          ? const String.fromEnvironment('GOOGLE_PLACE_ANDROID_KEY')
          : null;

  static String? googlePlaceIosKey =
      const bool.hasEnvironment('GOOGLE_PLACE_IOS_KEY')
          ? const String.fromEnvironment('GOOGLE_PLACE_IOS_KEY')
          : null;
}
