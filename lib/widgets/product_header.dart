import 'package:flutter/material.dart';
import '../core/app_config.dart';

class ProductHeader extends StatelessWidget {
  final String selectedRam;
  final ValueChanged<String> onRamChanged;
  final Map<String, dynamic>? apiProductData;

  const ProductHeader({
    super.key,
    required this.selectedRam,
    required this.onRamChanged,
    this.apiProductData,
  });

  @override
  Widget build(BuildContext context) {
    // Extract data from API if available
    String productTitle = 'Vivo X300 5G';
    String productImage = 'https://img-prd-pim.poorvika.com/product/Vivo-x300-5g-elite-black-12gb-512gb-Back-View.webp';
    String storeName = 'vivo';
    
    if (apiProductData != null) {
      try {
        final data = apiProductData!['data'];
        // New backend shape: { query, results: [{source, title, price, image, url}], ... }
        final results = data['results'] as List?;
        if (results != null && results.isNotEmpty) {
          final firstProduct = results[0] as Map<String, dynamic>;
          productTitle = (firstProduct['title'] ?? 'Product').toString();
          storeName = (firstProduct['source'] ?? 'vivo').toString();
          
          // Route through a public image proxy to avoid hotlinking/CORS issues
          final originalImage = (firstProduct['image'] ?? '').toString();
          if (originalImage.isNotEmpty) {
            productImage = '${AppConfig.imageProxyBaseUrl}${Uri.encodeComponent(originalImage)}';
          }
        }
      } catch (e) {
        print('Error extracting API data in ProductHeader: $e');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        // Store logo + title row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StoreLogo(storeName: storeName),
            const SizedBox(width: 10),
            const Text(
              ' - ',
              style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
            ),
            Expanded(
              child: Text(
                'Online Price Comparison and Price History of $productTitle',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF212121),
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // RAM selector chips
        Row(
          children: [
            _RamChip(
              label: 'Ram: 12 Gb',
              selected: selectedRam == '12 Gb',
              onTap: () => onRamChanged('12 Gb'),
            ),
            const SizedBox(width: 10),
            _RamChip(
              label: 'Rom: 256 Gb',
              selected: selectedRam == '256 Gb',
              onTap: () => onRamChanged('256 Gb'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Product image + details row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone image with API data
            _PhoneImageCard(productImage: productImage),
            const SizedBox(width: 24),
            // Right side: action buttons + side icons
            Expanded(child: _RightSideIcons()),
          ],
        ),
      ],
    );
  }
}

class _StoreLogo extends StatelessWidget {
  final String storeName;
  
  const _StoreLogo({required this.storeName});

  Color _getStoreColor(String storeName) {
    final name = storeName.toLowerCase();
    if (name.contains('flipkart')) return const Color(0xFF2874F0);
    if (name.contains('amazon')) return const Color(0xFFFF9900);
    if (name.contains('croma')) return const Color(0xFF00A650);
    if (name.contains('vijay sales') || name.contains('vijaysales')) return const Color(0xFFE91E63);
    if (name.contains('reliance digital') || name.contains('reliance')) return const Color(0xFF1976D2);
    if (name.contains('tata cliq') || name.contains('cliq')) return const Color(0xFF4CAF50);
    if (name.contains('paytm mall') || name.contains('paytm')) return const Color(0xFF00897B);
    if (name.contains('vivo')) return const Color(0xFF1A5AFF);
    return const Color(0xFF757575); // Default gray
  }

  @override
  Widget build(BuildContext context) {
    final color = _getStoreColor(storeName);
    String displayName = storeName;
    
    // Format name for display
    if (storeName.length <= 3) {
      displayName = storeName.toUpperCase();
    } else {
      displayName = storeName.split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        displayName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}

class _RamChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RamChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1565C0) : Colors.white,
          border: Border.all(
            color: selected ? const Color(0xFF1565C0) : const Color(0xFFBDBDBD),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF424242),
          ),
        ),
      ),
    );
  }
}

class _PhoneImageCard extends StatelessWidget {
  final String productImage;
  
  const _PhoneImageCard({required this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 360,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Center(
        child: Image.network(
          productImage,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            print("fdasfew -- $error");
            return Container(
              width: 300,
              height: 360,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RightSideIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEB3B),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: const [
              Icon(Icons.list_alt, size: 18, color: Colors.black87),
              SizedBox(height: 2),
              Text(
                'Prod\nDetails',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 8, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
