class FlavorConfig {
  static FlavorConfig? _instance;

  FlavorConfig._internal({
    required this.flavor,
    required this.values,
  });

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(flavor: flavor, values: values);
    return _instance!;
  }

  final Flavor flavor;
  final FlavorValues values;

  factory FlavorConfig.production() {
    return FlavorConfig(
      flavor: Flavor.production,
      values: FlavorValues(
        appTitle: 'QAgency',
        apiUrl: 'https://api.themoviedb.org/3/',
        posterUrl: 'https://image.tmdb.org/t/p/w500',
      ),
    );
  }

  factory FlavorConfig.development() {
    return FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(
        appTitle: 'QAgency Dev',
        apiUrl: 'https://dev.api.themoviedb.org/3/',
        posterUrl: 'https://dev.image.tmdb.org/t/p/w500',
      ),
    );
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception(
        'FlavorConfig is not initialized. Call a factory constructor first.',
      );
    }
    return _instance!;
  }

  bool get isProduction => instance.flavor == Flavor.production;
  bool get isDevelopment => instance.flavor == Flavor.development;
}

enum Flavor { production, development }

class FlavorValues {
  final String appTitle;
  final String apiUrl;
  final String posterUrl;

  FlavorValues({
    required this.appTitle,
    required this.apiUrl,
    required this.posterUrl,
  });
}
