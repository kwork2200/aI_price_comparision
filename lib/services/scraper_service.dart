import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class ScraperService {
  // IMPORTANT: Use your computer's IP address for mobile testing
  // Find your IP: Open CMD and run: ipconfig
  // Look for "IPv4 Address" under your active network adapter
  // 
  // Example: If your IP is 192.168.1.5, use:
  // static const String baseUrl = 'http://192.168.1.5:3000/api';
  
  // For WEB (Chrome) - works with localhost
  static const String baseUrlWeb = 'http://localhost:3000/api';
  
  // For MOBILE (Physical device/emulator) - use your computer's IP
  // Replace 192.168.29.158 with YOUR computer's actual IP address
  static const String baseUrlMobile = 'http://192.168.29.158:3000/api';
  
  // For production (deployed API)
  static const String baseUrlProduction = 'https://your-api-domain.com/api';

  /// Get the correct base URL based on platform
  static String get baseUrl {
    if (kIsWeb) {
      return baseUrlWeb;
    }
    // For mobile, return mobile URL
    return baseUrlMobile;
  }

  /// Scrape product data from any supported URL
  static Future<Map<String, dynamic>> scrapeProduct(String url) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/scrape'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to scrape: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error scraping product: $e');
    }
  }

  /// Scrape specifically from Flipkart
  static Future<Map<String, dynamic>> scrapeFlipkart(String url) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/scrape/flipkart'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to scrape Flipkart: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error scraping Flipkart: $e');
    }
  }

  /// Compare prices across multiple stores
  static Future<Map<String, dynamic>> comparePrices(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/compare?query=${Uri.encodeComponent(query)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to compare: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error comparing prices: $e');
    }
  }

  /// Get price history for a product
  static Future<List<Map<String, dynamic>>> getPriceHistory(String productId) async {
    // Mock data for now - replace with actual API call
    return [
      {'date': '2024-01-01', 'price': 45000},
      {'date': '2024-02-01', 'price': 43000},
      {'date': '2024-03-01', 'price': 42000},
      {'date': '2024-04-01', 'price': 40000},
      {'date': '2024-05-01', 'price': 37999},
    ];
  }
}

/// Product Model
class Product {
  final String name;
  final String price;
  final String? originalPrice;
  final String? discount;
  final String? rating;
  final String? reviewCount;
  final String? image;
  final List<String> highlights;
  final Map<String, String> specifications;
  final String availability;
  final String? seller;
  final String source;

  Product({
    required this.name,
    required this.price,
    this.originalPrice,
    this.discount,
    this.rating,
    this.reviewCount,
    this.image,
    this.highlights = const [],
    this.specifications = const {},
    this.availability = 'Unknown',
    this.seller,
    required this.source,
  });

  factory Product.fromJson(Map<String, dynamic> json, String source) {
    final data = json['data'] ?? json;
    
    return Product(
      name: data['name'] ?? 'Unknown Product',
      price: data['price'] ?? 'Price not available',
      originalPrice: data['originalPrice'],
      discount: data['discount'],
      rating: data['rating'],
      reviewCount: data['reviewCount'],
      image: data['image'],
      highlights: List<String>.from(data['highlights'] ?? []),
      specifications: Map<String, String>.from(data['specifications'] ?? {}),
      availability: data['availability'] ?? 'Unknown',
      seller: data['seller'],
      source: source,
    );
  }

  /// Get numeric price value
  double get numericPrice {
    final cleanPrice = price.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(cleanPrice) ?? 0;
  }

  /// Get numeric original price value
  double? get numericOriginalPrice {
    if (originalPrice == null) return null;
    final cleanPrice = originalPrice!.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(cleanPrice);
  }

  /// Calculate savings
  double? get savings {
    if (numericOriginalPrice == null) return null;
    return numericOriginalPrice! - numericPrice;
  }

  /// Calculate discount percentage
  double? get discountPercentage {
    if (numericOriginalPrice == null || numericOriginalPrice == 0) return null;
    return ((numericOriginalPrice! - numericPrice) / numericOriginalPrice!) * 100;
  }
}

/// Store Comparison Model
class StoreComparison {
  final String name;
  final String price;
  final String originalPrice;
  final String discount;
  final String cashback;
  final String finalPrice;
  final String url;
  final bool inStock;

  StoreComparison({
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.cashback,
    required this.finalPrice,
    required this.url,
    required this.inStock,
  });

  factory StoreComparison.fromJson(Map<String, dynamic> json) {
    return StoreComparison(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      originalPrice: json['originalPrice'] ?? '',
      discount: json['discount'] ?? '',
      cashback: json['cashback'] ?? '',
      finalPrice: json['finalPrice'] ?? '',
      url: json['url'] ?? '',
      inStock: json['inStock'] ?? false,
    );
  }
}
