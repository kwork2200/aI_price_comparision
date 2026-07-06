import 'package:get/get.dart';

class HomeController extends GetxController {
  // Product Data
  final productName = 'Samsung Galaxy S23 5G AI Smartphone'.obs;
  final currentPrice = 37999.obs;
  final lowestPrice = 37999.obs;
  final highestPrice = 89999.obs;
  
  // Search
  RxString searchQuery = ''.obs;
  RxBool isSearching = false.obs;
  
  // Price History Data (for graph)
  final priceHistory = <PricePoint>[
    PricePoint(date: '1 Mar', price: 40000),
    PricePoint(date: '1 Apr', price: 48000),
    PricePoint(date: '15 Apr', price: 42000),
    PricePoint(date: '1 May', price: 37999),
  ].obs;

  // Store Comparisons
  final stores = <StorePrice>[
    StorePrice(
      name: 'croma',
      originalPrice: 44994,
      discount: 185,
      finalPrice: 44809,
      cashback: '₹185',
      color: 0xFF00BFA5,
    ),
    StorePrice(
      name: 'Flipkart',
      originalPrice: 45999,
      discount: 0,
      finalPrice: 45999,
      cashback: 'Rewards',
      color: 0xFF2874F0,
    ),
    StorePrice(
      name: 'Amazon',
      originalPrice: 46999,
      discount: 500,
      finalPrice: 46499,
      cashback: '₹500',
      color: 0xFFFF9900,
    ),
  ].obs;

  // Product Specs
  final specs = <ProductSpec>[
    ProductSpec(label: 'Ram: 8 Gb', value: '8GB'),
    ProductSpec(label: 'Rom: 128 Gb', value: '128GB'),
    ProductSpec(label: 'Battery: 3900 Mah', value: '3900mAh'),
    ProductSpec(label: 'Rear Camera: 50 Mp, 10 Mp, 12 Mp', value: '50MP+10MP+12MP'),
    ProductSpec(label: 'Front Camera: 12 Mp', value: '12MP'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) searchQuery.value = '';
  }

  void updateSearchQuery(String query) => searchQuery.value = query;

  // Get best deal store
  StorePrice get bestDeal {
    return stores.reduce((a, b) => a.finalPrice < b.finalPrice ? a : b);
  }
}

class PricePoint {
  final String date;
  final int price;

  PricePoint({required this.date, required this.price});
}

class StorePrice {
  final String name;
  final int originalPrice;
  final int discount;
  final int finalPrice;
  final String cashback;
  final int color;

  StorePrice({
    required this.name,
    required this.originalPrice,
    required this.discount,
    required this.finalPrice,
    required this.cashback,
    required this.color,
  });
}

class ProductSpec {
  final String label;
  final String value;

  ProductSpec({required this.label, required this.value});
}