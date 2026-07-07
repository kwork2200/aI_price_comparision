import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/action_buttons_row.dart';
import '../../widgets/breadcrumb_bar.dart';
import '../../widgets/navigation_bar.dart';
import '../../widgets/price_info_bar.dart';
import '../../widgets/product_header.dart';
import '../../widgets/store_price_card.dart';
import '../../services/price_api_service.dart';
import '../theme/theme_controller.dart';
import 'widgets/url_search_widget.dart';
import '../about_us/about_us_view.dart';
import '../contact_us/contact_us_view.dart';
import '../privacy_policy/privacy_policy_view.dart';
import '../terms_conditions/terms_conditions_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, dynamic>? scrapedProduct;

  static const _blue = Color(0xFF415FFF);
  static const _green = Color(0xFF00C853);
  static const _yellow = Color(0xFFFFD700);
  static const _purple = Color(0xFFAB47BC);
  static const _croma = Color(0xFF007A60);
  static const _flip = Color(0xFF2874F0);
  static const _amz = Color(0xFFFF9900);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark =
        themeController.themeMode == ThemeMode.dark ||
        (themeController.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1a1a2e)
          : const Color(0xFFF5F6FA),
      body: Column(
        children: [
          const AppNavigationBar(),
          Expanded(
            child: SafeArea(child: _getCurrentScreen()),
          ),
        ],
      ),
    );
  }

  Widget _getCurrentScreen() {
    final currentRoute = Get.currentRoute;
    
    switch (currentRoute) {
      case '/home':
        return const PriceComparisonScreen();
      case '/about_us':
        return const AboutUsView();
      case '/contact_us':
        return const ContactUsView();
      case '/privacy_policy':
        return const PrivacyPolicyView();
      case '/terms_conditions':
        return const TermsConditionsView();
      default:
        return const PriceComparisonScreen();
    }
  }
}

class PriceComparisonScreen extends StatefulWidget {
  const PriceComparisonScreen({super.key});

  @override
  State<PriceComparisonScreen> createState() => _PriceComparisonScreenState();
}

class _PriceComparisonScreenState extends State<PriceComparisonScreen> {
  String selectedRam = '12 Gb';
  bool showImagesAndTitles = false;

  // API Response data
  Map<String, dynamic>? apiProductData;
  List<StorePrice> apiStores = [];

  // Default mock data (fallback)
  final List<StorePrice> defaultStores = [
    StorePrice(
      storeName: 'croma',
      productTitle: 'Xiaomi 13 Pro 5G',
      price: '₹75,814',
      oldPrice: '₹75,999',
      link: 'https://www.croma.com/xiaomi-13-pro',
      thumbnail: '',
      rating: '4.5',
      reviews: '156',
      delivery: 'Free delivery',
    ),
    StorePrice(
      storeName: 'Flipkart',
      productTitle: 'Xiaomi 13 Pro 5G',
      price: '₹75,999',
      link: 'https://www.flipkart.com/xiaomi-13-pro',
      thumbnail: '',
      rating: '4.7',
      reviews: '198',
      delivery: 'Free delivery by Thu',
    ),
    StorePrice(
      storeName: 'Amazon',
      productTitle: 'Xiaomi 13 Pro 5G',
      price: '₹79,999',
      oldPrice: '₹89,999',
      link: 'https://www.amazon.in/xiaomi-13-pro',
      thumbnail: '',
      rating: '4.6',
      reviews: '245',
      delivery: 'Free delivery',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: UrlSearchWidget(
                  isDark: false,
                  onProductScraped: (productData) {
                    // API Response - Product aur store prices mil gaye
                    print('✅ Product: ${productData['data']['name']}');
                    print('💰 Price: ${productData['data']['price']}');
                    print(
                      '🏪 Stores: ${(productData['stores'] as List).length}',
                    );

                    // Update UI with API data
                    setState(() {
                      apiProductData = productData;
                      apiStores = (productData['stores'] as List).map((store) {
                        return StorePrice(
                          storeName: store['name']?.toString() ?? 'Unknown',
                          productTitle: store['title']?.toString() ?? 'Product',
                          price:
                              store['price']?.toString() ??
                              'Price Not Available',
                          oldPrice: store['old_price']?.toString(),
                          extractedPrice: store['extracted_price']?.toString(),
                          extractedOldPrice: store['extracted_old_price']
                              ?.toString(),
                          link: store['link']?.toString() ?? '',
                          productLink: store['product_link']?.toString() ?? '',
                          thumbnail: store['thumbnail']?.toString() ?? '',
                          rating: store['rating']?.toString(),
                          reviews: store['reviews']?.toString(),
                          delivery: store['delivery']?.toString(),
                          productId: store['product_id']?.toString(),
                          immersiveProductPageToken:
                              store['immersive_product_page_token']?.toString(),
                          multipleSources: store['multiple_sources'] as bool?,
                          serpapiImmersiveProductApi:
                              store['serpapi_immersive_product_api']
                                  ?.toString(),
                          sourceIcon: store['source_icon']?.toString(),
                          position: store['position'] as int?,
                        );
                      }).toList();
                    });
                  },
                ),
              ),
            ),
            const BreadcrumbBar(),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;

                if (isMobile) {
                  // Mobile layout: Search → Image → Comparison (vertical)
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: apiStores.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image at top for mobile
                              ProductHeader(
                                selectedRam: selectedRam,
                                onRamChanged: (ram) => setState(() => selectedRam = ram),
                                apiProductData: apiProductData,
                              ),
                              const SizedBox(height: 16),
                              // Price History Section
                              PriceHistorySection(
                                stores: apiStores,
                                showImagesAndTitles: showImagesAndTitles,
                                onToggle: (val) =>
                                    setState(() => showImagesAndTitles = val),
                              ),
                              const SizedBox(height: 16),
                              ActionButtonsRow(),
                              const SizedBox(height: 16),
                              PriceInfoBar(
                                showImagesAndTitles: showImagesAndTitles,
                                onToggle: (val) =>
                                    setState(() => showImagesAndTitles = val),
                              ),
                              const SizedBox(height: 16),
                              ...apiStores.map(
                                (store) => Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: StorePriceCard(storePrice: store),
                                ),
                              ),
                            ],
                          )
                        : _buildEmptySearchView(),
                  );
                }

                // Desktop layout: Side by side
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      apiStores.isNotEmpty
                          ? Expanded(
                              flex: 1,
                              child: ProductHeader(
                                selectedRam: selectedRam,
                                onRamChanged: (ram) => setState(() => selectedRam = ram),
                                apiProductData: apiProductData,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 3,
                        child: apiStores.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PriceHistorySection(
                                    stores: apiStores,
                                    showImagesAndTitles: showImagesAndTitles,
                                    onToggle: (val) =>
                                        setState(() => showImagesAndTitles = val),
                                  ),
                                  const SizedBox(height: 16),
                                  ActionButtonsRow(),
                                  const SizedBox(height: 16),
                                  PriceInfoBar(
                                    showImagesAndTitles: showImagesAndTitles,
                                    onToggle: (val) =>
                                        setState(() => showImagesAndTitles = val),
                                  ),
                                  const SizedBox(height: 16),
                                  ...apiStores.map(
                                    (store) => Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: StorePriceCard(storePrice: store),
                                    ),
                                  ),
                                ],
                              )
                            : _buildEmptySearchView(),
                      ),
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySearchView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: isMobile ? 48 : 64,
                color: Color(0xFF9E9E9E),
              ),
              const SizedBox(height: 16),
              Text(
                'Search for a Product',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Enter a product URL or name to compare prices across different stores and see price history',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1565C0).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF1565C0),
                      size: isMobile ? 16 : 20,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Tip: Paste Flipkart/Amazon URL',
                        style: TextStyle(
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w500,
                          fontSize: isMobile ? 11 : 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class PriceHistorySection extends StatefulWidget {
  final List<StorePrice> stores;
  final bool showImagesAndTitles;
  final ValueChanged<bool> onToggle;

  const PriceHistorySection({
    super.key,
    required this.stores,
    required this.showImagesAndTitles,
    required this.onToggle,
  });

  @override
  State<PriceHistorySection> createState() => _PriceHistorySectionState();
}

class _PriceHistorySectionState extends State<PriceHistorySection> {
  @override
  Widget build(BuildContext context) {
    // Prices nikaalo stores se
    final prices = widget.stores
        .map((s) => s.numericPrice)
        .where((p) => p > 0)
        .toList();

    // Calculate lowest and highest prices
    final lowestPrice = prices.isNotEmpty
        ? prices.reduce((a, b) => a < b ? a : b)
        : 0.0;
    final highestPrice = prices.isNotEmpty
        ? prices.reduce((a, b) => a > b ? a : b)
        : 0.0;
    final todayPrice = prices.isNotEmpty ? prices.first : 0.0;
    
    // Debug print to verify prices
    print('📊 Price Analysis:');
    print('  - Lowest Price: ₹${lowestPrice.toStringAsFixed(0)}');
    print('  - Highest Price: ₹${highestPrice.toStringAsFixed(0)}');
    print('  - Today\'s Price: ₹${todayPrice.toStringAsFixed(0)}');
    print('  - Available Prices: $prices');

    // Mock historical data (aap apna real data yahan dal sakte ho)
    final List<FlSpot> spots = [
      FlSpot(0, highestPrice),
      FlSpot(1, lowestPrice),
      FlSpot(2, lowestPrice * 1.1),
      FlSpot(3, todayPrice),
    ];

    final dates = ['13 Apr', '20 Apr', '27 Apr', '4 May'];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        if (isMobile) {
          // Mobile: Stack vertically
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Live indicator row
              Row(
                children: [
                  Icon(Icons.done, color: Color(0xFF43A047)),
                  const SizedBox(width: 6),
                  const Text(
                    'Live! Prices Updated',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF43A047),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Show images checkbox
              GestureDetector(
                onTap: () => widget.onToggle(!widget.showImagesAndTitles),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF9E9E9E),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(3),
                        color: widget.showImagesAndTitles
                            ? const Color(0xFF1565C0)
                            : Colors.white,
                      ),
                      child: widget.showImagesAndTitles
                          ? const Icon(Icons.check, size: 11, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Show Images & Titles',
                      style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Price History Graph
              _buildPriceChart(lowestPrice, highestPrice, todayPrice, spots, dates),
              const SizedBox(height: 16),
              // Today's Price Info
              _buildPriceInfo(lowestPrice, highestPrice, todayPrice),
            ],
          );
        }
        
        // Desktop: Row layout
        return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.done, color: Color(0xFF43A047)),
                const SizedBox(width: 6),
                const Text(
                  'Live! Prices Updated',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF43A047),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            // Show images checkbox
            GestureDetector(
              onTap: () => widget.onToggle(!widget.showImagesAndTitles),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF9E9E9E),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(3),
                      color: widget.showImagesAndTitles
                          ? const Color(0xFF1565C0)
                          : Colors.white,
                    ),
                    child: widget.showImagesAndTitles
                        ? const Icon(Icons.check, size: 11, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Show Images & Titles',
                    style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price History Graph',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: (highestPrice - lowestPrice) / 3,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: const Color(0xFFE0E0E0),
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'Price',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 55,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${(value / 1000).toStringAsFixed(0)}k',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text(
                          'Date',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final idx = value.toInt();
                            if (idx < 0 || idx >= dates.length) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              dates[idx],
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: false,
                        color: const Color(0xFF1565C0),
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) =>
                              FlDotCirclePainter(
                                radius: 4,
                                color: const Color(0xFF1565C0),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              ),
                        ),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    minX: 0,
                    maxX: 3,
                    minY: lowestPrice * 0.9,
                    maxY: highestPrice * 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),

        // Right: Today's Price + Lowest/Highest + Alert Button
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Price
              RichText(
                text: TextSpan(
                  text: "Today's Price: ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                  children: [
                    TextSpan(
                      text: '₹${todayPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFFD32F2F),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Lowest / Highest chips
              Row(
                children: [
                  _PriceChip(
                    label: '₹${lowestPrice.toStringAsFixed(0)}',
                    sublabel: '(Lowest)',
                    color: const Color(0xFF43A047),
                  ),
                  const SizedBox(width: 8),
                  _PriceChip(
                    label: '₹${highestPrice.toStringAsFixed(0)}',
                    sublabel: '(Highest)',
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Progress bar (lowest → highest)
              _PriceRangeBar(
                low: lowestPrice,
                high: highestPrice,
                current: todayPrice,
              ),

              const SizedBox(height: 20),

              // Get Price Drop Alert button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Alert action
                  },
                  icon: const Icon(Icons.show_chart, size: 16),
                  label: const Text(
                    'Get Price Drop Alert',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF43A047),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(flex: 6, child: Container()),
      ],
    );
      }
    );
  }

  Widget _buildPriceChart(double lowestPrice, double highestPrice, double todayPrice, 
      List<FlSpot> spots, List<String> dates) {
    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: (highestPrice - lowestPrice) / 3,
            getDrawingHorizontalLine: (value) => FlLine(
              color: const Color(0xFFE0E0E0),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameWidget: const Text(
                'Price',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 55,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${(value / 1000).toStringAsFixed(0)}k',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: const Text(
                'Date',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= dates.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    dates[idx],
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: const Color(0xFF1565C0),
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: const Color(0xFF1565C0),
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    ),
              ),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: 0,
          maxX: 3,
          minY: lowestPrice * 0.9,
          maxY: highestPrice * 1.1,
        ),
      ),
    );
  }

  Widget _buildPriceInfo(double lowestPrice, double highestPrice, double todayPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Today's Price
        RichText(
          text: TextSpan(
            text: "Today's Price: ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212121),
            ),
            children: [
              TextSpan(
                text: '₹${todayPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Color(0xFFD32F2F),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Lowest / Highest chips
        Row(
          children: [
            _PriceChip(
              label: '₹${lowestPrice.toStringAsFixed(0)}',
              sublabel: '(Lowest)',
              color: const Color(0xFF43A047),
            ),
            const SizedBox(width: 8),
            _PriceChip(
              label: '₹${highestPrice.toStringAsFixed(0)}',
              sublabel: '(Highest)',
              color: const Color(0xFFD32F2F),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Progress bar
        _PriceRangeBar(
          low: lowestPrice,
          high: highestPrice,
          current: todayPrice,
        ),
        const SizedBox(height: 20),
        // Alert Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.show_chart, size: 16),
            label: const Text(
              'Get Price Drop Alert',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43A047),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceChip extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;

  const _PriceChip({
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          Text(
            sublabel,
            style: const TextStyle(color: Colors.white70, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _PriceDropButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // TODO: Price drop alert action
      },
      icon: const Icon(Icons.notifications, size: 16),
      label: const Text(
        'Alert',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF43A047),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class _PriceRangeBar extends StatelessWidget {
  final double low;
  final double high;
  final double current;

  const _PriceRangeBar({
    required this.low,
    required this.high,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final fraction = high > low
        ? ((current - low) / (high - low)).clamp(0.0, 1.0)
        : 0.5;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            // Bar background (gradient green → yellow → red)
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF43A047),
                    Color(0xFFFFD700),
                    Color(0xFFD32F2F),
                  ],
                ),
              ),
            ),
            // Dot indicator
            Positioned(
              left: (constraints.maxWidth * fraction) - 8,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF43A047), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
