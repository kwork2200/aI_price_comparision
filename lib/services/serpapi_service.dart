import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class SerpApiService {
  // ⚠️⚠️⚠️ IMPORTANT: API Key yahan daalo!
  // Screenshot se API Key copy karo aur niche paste karo
  // Example: static const String _apiKey = 'a20c1b9f9020f...';
  static const String _apiKey = 'ab366e0dd39e77f35340ed7a5e7c00f5a7e06a1a2eda2b1958ac1ca834400fc0';
  
  // IMPORTANT: Use your computer's IP address for mobile testing
  // Find your IP: Open CMD and run: ipconfig
  // Look for "IPv4 Address" under your active network adapter
  // Replace 192.168.29.158 with YOUR computer's actual IP address
  static const String _serverUrlWeb = 'http://localhost:3000/api/serpapi/search';
  static const String _serverUrlMobile = 'http://192.168.29.158:3000/api/serpapi/search';
  
  // For Mobile - can use direct API
  static const String _directBaseUrl = 'https://serpapi.com/search.json';

  /// Get the correct server URL based on platform
  static String get _serverUrl {
    if (kIsWeb) {
      return _serverUrlWeb;
    }
    return _serverUrlMobile;
  }

  /// Get the correct API URL based on platform
  static String get _baseUrl {
    if (kIsWeb) {
      // Web: Use local server to avoid CORS
      return _serverUrl;
    }
    // Mobile: Use direct API
    return _directBaseUrl;
  }

  /// URL se product name extract karke search karo
  static Future<Map<String, dynamic>> searchFromUrl(String productUrl) async {
    // Step 1: URL se product name extract karo
    final productName = _extractProductNameFromUrl(productUrl);
    print('Extracted product name: $productName');
    
    // Step 2: SerpApi se search karo
    return await searchProduct(productName);
  }

  /// Product name se Google Shopping search
  static Future<Map<String, dynamic>> searchProduct(String productName) async {
    Uri url;
    
    if (kIsWeb) {
      // Web: Call local server
      url = Uri.parse(_serverUrl).replace(queryParameters: {
        'q': productName,
        'engine': 'google_shopping',
      });
    } else {
      // Mobile: Call direct API
      url = Uri.parse(_directBaseUrl).replace(queryParameters: {
        'engine': 'google_shopping',
        'q': productName,
        'api_key': _apiKey,
        'gl': 'in',
        'hl': 'en',
        'num': '20',
      });
    }

    print('Calling API (${kIsWeb ? "via server" : "direct"}): $url');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      
      // Server response wrapper check
      if (responseData['success'] == true && responseData['data'] != null) {
        return responseData['data'];
      }
      
      // Direct API response
      return responseData;
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
      
      // Flipkart: /vivo-x300-mist-blue-256-gb/p/itm...
      // Amazon: /Vivo-X300-Summit-Red/dp/...
      
      final parts = path.split('/');
      
      for (var part in parts) {
        if (part.isNotEmpty && 
            !part.startsWith('itm') && 
            !part.startsWith('p') &&
            !part.startsWith('dp') &&
            !part.startsWith('B0')) {
          // Hyphens aur special chars ko spaces mein convert karo
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
    
    // Agar extract nahi hua to pura URL return karo
    return url;
  }

  /// Shopping results se store prices extract karo
  static List<StorePrice> extractStorePrices(Map<String, dynamic> response) {
    final List<dynamic> shoppingResults = response['shopping_results'] ?? [];
    List<StorePrice> prices = [];
    Set<String> uniqueTitles = {};

    for (var item in shoppingResults) {
      final title = item['title'] ?? '';
      final source = item['source'] ?? 'Unknown';
      
      // Duplicate products filter karo
      // Same title with different stores - keep first one
      // Same store with same title - skip duplicates
      final uniqueKey = '${source}_${title}';
      
      if (!uniqueTitles.contains(uniqueKey) && title.isNotEmpty) {
        uniqueTitles.add(uniqueKey);
        prices.add(StorePrice.fromApiResponse(item));
      }
    }

    // Additional filtering: same product from different stores ko group karo
    return _groupSimilarProducts(prices);
  }

  /// Similar products ko group karo aur unique products return karo
  static List<StorePrice> _groupSimilarProducts(List<StorePrice> products) {
    List<StorePrice> uniqueProducts = [];
    Set<String> processedTitles = {};

    for (var product in products) {
      final title = product.productTitle.toLowerCase();
      
      // Title similarity check - same product with small variations
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

  /// Check if two product titles are similar (same product)
  static bool _areTitlesSimilar(String title1, String title2) {
    // Remove common words and compare
    final clean1 = _cleanTitle(title1);
    final clean2 = _cleanTitle(title2);
    
    // Exact match
    if (clean1 == clean2) return true;
    
    // Partial match (70% similarity)
    final similarity = _calculateSimilarity(clean1, clean2);
    return similarity > 0.7;
  }

  /// Clean title by removing common words and special chars
  static String _cleanTitle(String title) {
    final commonWords = ['gb', 'ram', 'storage', 'with', 'without', 'and', 'or', 'the', 'in', 'on', 'at'];
    final words = title.toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(' ')
        .where((word) => word.isNotEmpty && !commonWords.contains(word))
        .toList();
    
    return words.join(' ');
  }

  /// Calculate similarity between two strings
  static double _calculateSimilarity(String s1, String s2) {
    final longer = s1.length > s2.length ? s1 : s2;
    final shorter = s1.length > s2.length ? s2 : s1;
    
    if (longer.isEmpty) return 1.0;
    
    final editDistance = _levenshteinDistance(longer, shorter);
    return (longer.length - editDistance) / longer.length;
  }

  /// Calculate Levenshtein distance
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
          matrix[i - 1][j] + 1,     // deletion
          matrix[i][j - 1] + 1,     // insertion
          matrix[i - 1][j - 1] + cost // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    
    return matrix[s1.length][s2.length];
  }

  /// Product detail get karo (for more info)
  static Future<Map<String, dynamic>> getProductDetail(String productId) async {
    final url = Uri.parse(_baseUrl).replace(queryParameters: {
      'engine': 'google_product',
      'product_id': productId,
      'api_key': _apiKey,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get product detail');
    }
  }
}

/// Store Price Model
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

  /// Get numeric price for sorting
  double get numericPrice {
    if (extractedPrice != null) {
      return double.tryParse(extractedPrice!) ?? 0;
    }
    // Parse from price string like "₹39,999"
    final clean = price.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(clean) ?? 0;
  }

  /// Get numeric old price for discount calculation
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

  /// Get discount percentage
  double get discountPercentage {
    if (numericOldPrice > 0) {
      return ((numericOldPrice - numericPrice) / numericOldPrice) * 100;
    }
    return 0;
  }

  /// Factory constructor from API response
  factory StorePrice.fromApiResponse(Map<String, dynamic> item) {
    return StorePrice(
      storeName: item['source'] ?? 'Unknown',
      productTitle: item['title'] ?? '',
      price: item['price'] ?? 'N/A',
      extractedPrice: item['extracted_price']?.toString(),
      extractedOldPrice: item['extracted_old_price']?.toString(),
      oldPrice: item['old_price'],
      link: item['link'] ?? '',
      productLink: item['product_link'] ?? '',
      thumbnail: item['thumbnail'] ?? '',
      rating: item['rating']?.toString(),
      reviews: item['reviews']?.toString(),
      delivery: item['delivery'],
      productId: item['product_id']?.toString(),
      immersiveProductPageToken: item['immersive_product_page_token'],
      multipleSources: item['multiple_sources'],
      serpapiImmersiveProductApi: item['serpapi_immersive_product_api'],
      sourceIcon: item['source_icon'],
      position: item['position'],
    );
  }
}
