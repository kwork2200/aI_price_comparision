import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../services/serpapi_service.dart';

class UrlSearchWidget extends StatefulWidget {
  final bool isDark;
  final Function(Map<String, dynamic>) onProductScraped;

  const UrlSearchWidget({
    Key? key,
    required this.isDark,
    required this.onProductScraped,
  }) : super(key: key);

  @override
  State<UrlSearchWidget> createState() => _UrlSearchWidgetState();
}

class _UrlSearchWidgetState extends State<UrlSearchWidget> {
  final TextEditingController _urlController = TextEditingController(text: "https://www.flipkart.com/vivo-x300-mist-blue-256-gb/p/itm1e38d5ea8a0b4?pid=MOBHHZBCZYZHY24Q&lid=LSTMOBHHZBCZYZHY24QTSJRX1&marketplace=FLIPKART&cmpid=content_mobile_8965229628_gmc");
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  List<StorePrice> _searchResults = [];

  Future<void> _scrapeProduct() async {
    final url = _urlController.text.trim();
    
    if (url.isEmpty) {
      setState(() => _error = 'Please enter a product URL');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _searchResults = [];
    });

    try {
      // Call SerpApi to search from URL
      final result = await SerpApiService.searchFromUrl(url);
      
      // Extract store prices from response
      final storePrices = SerpApiService.extractStorePrices(result);
      
      setState(() {
        _searchResults = storePrices;
        _isLoading = false;
      });
      
      // Pass complete API response with shopping_results
      if (storePrices.isNotEmpty) {
        final mainProduct = {
          'success': true,
          'source': 'serpapi',
          'data': result, // Pass complete API response with shopping_results
          'stores': storePrices.map((s) => {
            'name': s.storeName,
            'title': s.productTitle,
            'price': s.price,
            'extracted_price': s.extractedPrice,
            'extracted_old_price': s.extractedOldPrice,
            'old_price': s.oldPrice,
            'link': s.link,
            'product_link': s.productLink,
            'thumbnail': s.thumbnail,
            'rating': s.rating,
            'reviews': s.reviews,
            'delivery': s.delivery,
            'product_id': s.productId,
            'immersive_product_page_token': s.immersiveProductPageToken,
            'multiple_sources': s.multipleSources,
            'serpapi_immersive_product_api': s.serpapiImmersiveProductApi,
            'source_icon': s.sourceIcon,
            'position': s.position,
          }).toList(),
        };
        widget.onProductScraped(mainProduct);
      }
      
      Get.snackbar(
        'Success',
        'Found ${storePrices.length} stores with prices!',
        backgroundColor: const Color(0xFF00C853),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      String errorMessage = 'Error: $e';
      
      // Provide user-friendly error messages
      if (e.toString().contains('401')) {
        errorMessage = 'API Error: Please check your API key configuration';
      } else if (e.toString().contains('403')) {
        errorMessage = 'Access Denied: Please verify API permissions';
      } else if (e.toString().contains('404')) {
        errorMessage = 'Product not found. Try a different URL or product name';
      } else if (e.toString().contains('429')) {
        errorMessage = 'Too many requests. Please wait a moment and try again';
      } else if (e.toString().contains('500') || e.toString().contains('502')) {
        errorMessage = 'Server error. Please try again later';
      } else if (e.toString().contains('timeout') || e.toString().contains('SocketException')) {
        errorMessage = 'Network error. Please check your internet connection';
      }
      
      setState(() {
        _error = errorMessage;
        _isLoading = false;
      });
    }
  }

  // Web ke liye compact sizing - chhota aur light
  double get _margin => kIsWeb ? 4 : 16.w;
  double get _padding => kIsWeb ? 8 : 16.w;
  double get _fontSizeSmall => kIsWeb ? 11 : 11.sp;
  double get _fontSizeMedium => kIsWeb ? 13 : 14.sp;
  double get _fontSizeLarge => kIsWeb ? 15 : 16.sp;
  double get _iconSize => kIsWeb ? 16 : 20.sp;
  double get _compactHeight => kIsWeb ? 4 : 12.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _margin, vertical: kIsWeb ? 4 : 12.h),
      padding: EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: widget.isDark ? const Color(0xFF16213e) : Colors.white,
        borderRadius: BorderRadius.circular(kIsWeb ? 8 : 12.r),
        boxShadow: kIsWeb 
          ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
              ),
            ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Icon(
                Icons.link,
                color: const Color(0xFF42A5F5),
                size: _iconSize,
              ),
              SizedBox(width: kIsWeb ? 6 : 8.w),
              Text(
                'Paste Product URL',
                style: TextStyle(
                  fontSize: _fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: widget.isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: _compactHeight),
          
          // URL Input
          Container(
            decoration: BoxDecoration(
              color: widget.isDark ? const Color(0xFF1a1a2e) : Colors.grey[100],
              borderRadius: BorderRadius.circular(kIsWeb ? 6 : 8.r),
              border: Border.all(
                color: _error != null 
                    ? Colors.red 
                    : (widget.isDark ? Colors.grey[700]! : Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    style: TextStyle(
                      fontSize: _fontSizeMedium,
                      color: widget.isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'https://www.flipkart.com/product-name/p/...',
                      hintStyle: TextStyle(
                        fontSize: kIsWeb ? 12 : 13.sp,
                        color: widget.isDark ? Colors.grey[500] : Colors.grey[400],
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: kIsWeb ? 12 : 16.w,
                        vertical: kIsWeb ? 10 : 14.h,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_urlController.text.isNotEmpty)
                  IconButton(
                    onPressed: () {
                      _urlController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.clear,
                      color: widget.isDark ? Colors.grey[400] : Colors.grey[600],
                      size: kIsWeb ? 14 : 18.sp,
                    ),
                  ),
              ],
            ),
          ),
          
          // Error Message
          if (_error != null) ...[
            SizedBox(height: kIsWeb ? 6 : 8.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: kIsWeb ? 8 : 12.w, 
                vertical: kIsWeb ? 6 : 8.h,
              ),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(kIsWeb ? 4 : 6.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: kIsWeb ? 12 : 16.sp,
                  ),
                  SizedBox(width: kIsWeb ? 4 : 8.w),
                  Expanded(
                    child: Text(
                      _error!,
                      style: TextStyle(
                        fontSize: kIsWeb ? 10 : 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          SizedBox(height: kIsWeb ? 6 : 12.h),
          
          // Supported Sites
          Wrap(
            spacing: kIsWeb ? 4 : 8.w,
            runSpacing: kIsWeb ? 3 : 6.h,
            children: [
              _buildSiteChip('Flipkart', const Color(0xFF2874F0)),
              _buildSiteChip('Amazon', const Color(0xFFFF9900)),
              _buildSiteChip('Croma', const Color(0xFF00BFA5)),
            ],
          ),
          
          SizedBox(height: kIsWeb ? 10 : 16.h),
          
          // Scrape Button
          SizedBox(
            width: double.infinity,
            height: kIsWeb ? 38 : null,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _scrapeProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C853),
                padding: EdgeInsets.symmetric(vertical: kIsWeb ? 0 : 14.h),
                minimumSize: kIsWeb ? const Size(double.infinity, 36) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kIsWeb ? 4 : 8.r),
                ),
                elevation: kIsWeb ? 1 : 2,
              ),
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: kIsWeb ? 16 : 18.w,
                          height: kIsWeb ? 16 : 18.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: kIsWeb ? 8 : 12.w),
                        Text(
                          'Scraping...',
                          style: TextStyle(
                            fontSize: _fontSizeMedium,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: kIsWeb ? 16 : 18.sp, color: Colors.white),
                        SizedBox(width: kIsWeb ? 6 : 8.w),
                        Text(
                          'Get Price Comparison',
                          style: TextStyle(
                            fontSize: _fontSizeMedium,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          
          SizedBox(height: kIsWeb ? 4 : 12.h),
          
          // Alternative: Search by product name
          Center(
            child: TextButton(
              onPressed: () {
                _showProductNameSearch();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: kIsWeb ? 8 : 16.w,
                  vertical: kIsWeb ? 4 : 8.h,
                ),
                minimumSize: kIsWeb ? const Size(0, 30) : null,
              ),
              child: Text(
                'Or search by product name',
                style: TextStyle(
                  fontSize: kIsWeb ? 11 : 13.sp,
                  color: const Color(0xFF42A5F5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSiteChip(String name, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 6 : 10.w, 
        vertical: kIsWeb ? 2 : 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(kIsWeb ? 2 : 4.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: kIsWeb ? 9 : 11.sp,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showProductNameSearch() {
    final TextEditingController nameController = TextEditingController();
    bool isLoading = false;
    
    Get.dialog(
      AlertDialog(
        backgroundColor: widget.isDark ? const Color(0xFF16213e) : Colors.white,
        title: Text(
          'Search by Product Name',
          style: TextStyle(
            fontSize: kIsWeb ? 16 : 18.sp,
            fontWeight: FontWeight.bold,
            color: widget.isDark ? Colors.white : Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(
                color: widget.isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: 'e.g., Samsung Galaxy S23',
                hintStyle: TextStyle(
                  color: widget.isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                filled: true,
                fillColor: widget.isDark ? const Color(0xFF1a1a2e) : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: kIsWeb ? 12 : 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (nameController.text.trim().isEmpty) return;
                        
                        Get.back();
                        
                        try {
                          final result = await SerpApiService.searchProduct(
                            nameController.text.trim(),
                          );
                          
                          final storePrices = SerpApiService.extractStorePrices(result);
                          
                          if (storePrices.isNotEmpty) {
                            final mainProduct = {
                              'success': true,
                              'source': 'serpapi',
                              'data': result, // Pass complete API response with shopping_results
                              'stores': storePrices.map((s) => {
                                'name': s.storeName,
                                'title': s.productTitle,
                                'price': s.price,
                                'extracted_price': s.extractedPrice,
                                'extracted_old_price': s.extractedOldPrice,
                                'old_price': s.oldPrice,
                                'link': s.link,
                                'product_link': s.productLink,
                                'thumbnail': s.thumbnail,
                                'rating': s.rating,
                                'reviews': s.reviews,
                                'delivery': s.delivery,
                                'product_id': s.productId,
                                'immersive_product_page_token': s.immersiveProductPageToken,
                                'multiple_sources': s.multipleSources,
                                'serpapi_immersive_product_api': s.serpapiImmersiveProductApi,
                                'source_icon': s.sourceIcon,
                                'position': s.position,
                              }).toList(),
                            };
                            widget.onProductScraped(mainProduct);
                          }
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to search: $e',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  padding: EdgeInsets.symmetric(vertical: kIsWeb ? 10 : 12.h),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(fontSize: kIsWeb ? 13 : 14.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Display scraped product data
class ScrapedProductCard extends StatelessWidget {
  final Map<String, dynamic> productData;
  final bool isDark;

  const ScrapedProductCard({
    Key? key,
    required this.productData,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = productData['data'] ?? productData;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16213e) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          if (data['image'] != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                data['image'],
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200.h,
                    color: isDark ? Colors.grey[800] : Colors.grey[200],
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50.sp,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
          
          // Product Name
          Text(
            data['name'] ?? 'Unknown Product',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          
          // Price Section
          Row(
            children: [
              Text(
                data['price'] ?? 'N/A',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF00C853),
                ),
              ),
              if (data['originalPrice'] != null) ...[
                SizedBox(width: 12.w),
                Text(
                  data['originalPrice'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    decoration: TextDecoration.lineThrough,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
              if (data['discount'] != null) ...[
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C853).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    data['discount'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF00C853),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          
          SizedBox(height: 12.h),
          
          // Rating & Reviews
          if (data['rating'] != null) ...[
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: const Color(0xFFFFD700),
                  size: 18.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  data['rating'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                if (data['reviewCount'] != null) ...[
                  SizedBox(width: 8.w),
                  Text(
                    '(${data['reviewCount']})',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 12.h),
          ],
          
          // Availability
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: (data['availability']?.toString().toLowerCase().contains('out') == true)
                  ? Colors.red.withOpacity(0.1)
                  : const Color(0xFF00C853).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              data['availability'] ?? 'Unknown',
              style: TextStyle(
                fontSize: 12.sp,
                color: (data['availability']?.toString().toLowerCase().contains('out') == true)
                    ? Colors.red
                    : const Color(0xFF00C853),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Highlights
          if (data['highlights'] != null && (data['highlights'] as List).isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              'Highlights',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            ...((data['highlights'] as List).map((highlight) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 14.sp,
                    color: const Color(0xFF00C853),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      highlight.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ))),
          ],
          
          // Specifications
          if (data['specifications'] != null && 
              (data['specifications'] as Map).isNotEmpty) ...[
            SizedBox(height: 16.h),
            Text(
              'Specifications',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1a1a2e) : Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: ((data['specifications'] as Map).entries.map((entry) => 
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            entry.key.toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            entry.value.toString(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
          
          SizedBox(height: 16.h),
          
          // Source
          Row(
            children: [
              Text(
                'Source: ',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Text(
                (productData['source'] ?? 'Unknown').toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF42A5F5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
