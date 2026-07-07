import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/app_config.dart';

/// Talks to our own in-house price-comparison backend (the /api folder,
/// deployed as Vercel Serverless Functions) instead of the third-party
/// SerpApi service that `SerpApiService` used to call.
///
/// Keeps the same public shape (`searchFromUrl`, `searchProduct`,
/// `extractStorePrices`, `StorePrice`) so call sites only need an import
/// swap plus the field-name changes noted where they read the raw map.
class PriceApiService {
  static String get _searchUrl => '${AppConfig.apiBaseUrl}/search';

  /// URL se product name extract karke search karo
  static Future<Map<String, dynamic>> searchFromUrl(String productUrl) async {
    final productName = _extractProductNameFromUrl(productUrl);
    print('Extracted product name: $productName');
    return await searchProduct(productName);
  }

  /// Product name se apna backend search karo
  static Future<Map<String, dynamic>> searchProduct(String productName) async {
    final url = Uri.parse(_searchUrl).replace(queryParameters: {'q': productName});

    print('Calling backend: $url');
    final response = await http.get(url).timeout(const Duration(seconds: 20));

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      if (responseData['success'] == true) {
        return responseData; // caller reads responseData['data']['results']
      }
      throw Exception(responseData['error'] ?? 'Backend returned an error');
    } else if (response.statusCode == 429) {
      throw Exception('Too many requests — please wait a moment and try again.');
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      throw Exception('API Error: ${response.statusCode}');
    }
  }

  /// Flipkart/Amazon URL se product name extract karo
  static String _extractProductNameFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final path = uri.path;
      final parts = path.split('/');

      for (var part in parts) {
        if (part.isNotEmpty &&
            !part.startsWith('itm') &&
            !part.startsWith('p') &&
            !part.startsWith('dp') &&
            !part.startsWith('B0')) {
          final cleanName = part
              .replaceAll('-', ' ')
              .replaceAll('_', ' ')
              .replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

          if (cleanName.isNotEmpty && cleanName.length > 3) {
            return cleanName;
          }
        }
      }
    } catch (e) {
      print('URL parse error: $e');
    }
    return url;
  }

  /// Backend response se store prices extract karo.
  /// Response shape: { success, data: { query, results: [...], sourceErrors } }
  static List<StorePrice> extractStorePrices(Map<String, dynamic> response) {
    final data = response['data'] as Map<String, dynamic>? ?? response;
    final List<dynamic> results = data['results'] ?? [];
    List<StorePrice> prices = [];
    Set<String> uniqueTitles = {};

    for (var item in results) {
      final title = item['title'] ?? '';
      final source = item['source'] ?? 'Unknown';
      final uniqueKey = '${source}_$title';

      if (!uniqueTitles.contains(uniqueKey) && title.isNotEmpty) {
        uniqueTitles.add(uniqueKey);
        prices.add(StorePrice.fromApiResponse(item));
      }
    }

    return _groupSimilarProducts(prices);
  }

  static List<StorePrice> _groupSimilarProducts(List<StorePrice> products) {
    List<StorePrice> uniqueProducts = [];
    Set<String> processedTitles = {};

    for (var product in products) {
      final title = product.productTitle.toLowerCase();
      bool isSimilar = false;
      for (var processedTitle in processedTitles) {
        if (_areTitlesSimilar(title, processedTitle)) {
          isSimilar = true;
          break;
        }
      }
      if (!isSimilar) {
        uniqueProducts.add(product);
        processedTitles.add(title);
      }
    }
    return uniqueProducts;
  }

  static bool _areTitlesSimilar(String title1, String title2) {
    final clean1 = _cleanTitle(title1);
    final clean2 = _cleanTitle(title2);
    if (clean1 == clean2) return true;
    final similarity = _calculateSimilarity(clean1, clean2);
    return similarity > 0.7;
  }

  static String _cleanTitle(String title) {
    final commonWords = ['gb', 'ram', 'storage', 'with', 'without', 'and', 'or', 'the', 'in', 'on', 'at'];
    final words = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(' ')
        .where((word) => word.isNotEmpty && !commonWords.contains(word))
        .toList();
    return words.join(' ');
  }

  static double _calculateSimilarity(String s1, String s2) {
    final longer = s1.length > s2.length ? s1 : s2;
    final shorter = s1.length > s2.length ? s2 : s1;
    if (longer.isEmpty) return 1.0;
    final editDistance = _levenshteinDistance(longer, shorter);
    return (longer.length - editDistance) / longer.length;
  }

  static int _levenshteinDistance(String s1, String s2) {
    final matrix = List.generate(s1.length + 1, (i) => List.filled(s2.length + 1, 0));
    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }
    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    return matrix[s1.length][s2.length];
  }
}

/// Store Price Model — same public shape as before so widgets don't need
/// changes, but `fromApiResponse` now reads our own backend's field names
/// (source/title/price/extractedPrice/image/url) instead of SerpApi's
/// (source/title/price/extracted_price/thumbnail/link).
class StorePrice {
  final String storeName;
  final String productTitle;
  final String price;
  final String? extractedPrice;
  final String? extractedOldPrice;
  final String? oldPrice;
  final String link;
  final String productLink;
  final String thumbnail;
  final String? rating;
  final String? reviews;
  final String? delivery;
  final String? productId;
  final String? immersiveProductPageToken;
  final bool? multipleSources;
  final String? serpapiImmersiveProductApi;
  final String? sourceIcon;
  final int? position;

  StorePrice({
    required this.storeName,
    required this.productTitle,
    required this.price,
    this.extractedPrice,
    this.extractedOldPrice,
    this.oldPrice,
    required this.link,
    this.productLink = '',
    required this.thumbnail,
    this.rating,
    this.reviews,
    this.delivery,
    this.productId,
    this.immersiveProductPageToken,
    this.multipleSources,
    this.serpapiImmersiveProductApi,
    this.sourceIcon,
    this.position,
  });

  double get numericPrice {
    if (extractedPrice != null) {
      return double.tryParse(extractedPrice!) ?? 0;
    }
    final clean = price.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(clean) ?? 0;
  }

  double get numericOldPrice {
    if (extractedOldPrice != null) {
      return double.tryParse(extractedOldPrice!) ?? 0;
    }
    if (oldPrice != null) {
      final clean = oldPrice!.replaceAll(RegExp(r'[^0-9]'), '');
      return double.tryParse(clean) ?? 0;
    }
    return 0;
  }

  double get discountPercentage {
    if (numericOldPrice > 0) {
      return ((numericOldPrice - numericPrice) / numericOldPrice) * 100;
    }
    return 0;
  }

  /// Our backend's item shape: { source, title, price, extractedPrice, image, url, rating }
  factory StorePrice.fromApiResponse(Map<String, dynamic> item) {
    return StorePrice(
      storeName: item['source'] ?? 'Unknown',
      productTitle: item['title'] ?? '',
      price: item['price'] ?? 'N/A',
      extractedPrice: item['extractedPrice']?.toString(),
      link: item['url'] ?? '',
      productLink: item['url'] ?? '',
      thumbnail: item['image'] ?? '',
      rating: item['rating']?.toString(),
    );
  }
}
