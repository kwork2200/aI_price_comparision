import 'package:flutter/material.dart';
import '../services/serpapi_service.dart';

class StorePriceCard extends StatefulWidget {
  final StorePrice storePrice;
  const StorePriceCard({super.key, required this.storePrice});

  @override
  State<StorePriceCard> createState() => _StorePriceCardState();
}

class _StorePriceCardState extends State<StorePriceCard> {
  bool _hoveredBuy = false;
  bool _hoveredShare = false;

  @override
  Widget build(BuildContext context) {
    final storePrice = widget.storePrice;
    final bool soldOut = false; // TODO: Determine from API response
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: isMobile
        ? _buildMobileLayout(storePrice, soldOut)
        : _buildDesktopLayout(storePrice, soldOut),
    );
  }

  Widget _buildDesktopLayout(StorePrice storePrice, bool soldOut) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: Store logo area
        Container(
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
          ),
          child: _StoreLogo(storePrice: storePrice),
        ),

        // Center: MRP column
        Container(
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
          ),
          child: soldOut
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF5350),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Sold Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      storePrice.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
        ),

        if (!soldOut)
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xFFEEEEEE))),
              ),
              child: _CashbackColumn(storePrice: storePrice),
            ),
          ),

        if (!soldOut) ...[
          Container(
            width: 30,
            alignment: Alignment.center,
            child: const Text(
              '=',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            width: 160,
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: _FinalPriceColumn(storePrice: storePrice),
          ),
        ],

        Container(
          width: 230,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: const BoxDecoration(
            color: Color(0xFFF8F9FA),
            border:
                Border(left: BorderSide(color: Color(0xFFE0E0E0))),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: _ActionButtonsColumn(
            storePrice: storePrice,
            hoveredBuy: _hoveredBuy,
            hoveredShare: _hoveredShare,
            onBuyHover: (v) => setState(() => _hoveredBuy = v),
            onShareHover: (v) => setState(() => _hoveredShare = v),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(StorePrice storePrice, bool soldOut) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store info row
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: _StoreLogo(storePrice: storePrice),
              ),
              if (!soldOut)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF43A047),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    storePrice.price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF43A047),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Discount and savings info
        if (!soldOut)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${storePrice.discountPercentage.toStringAsFixed(0)}% OFF',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF43A047),
                    ),
                  ),
                ),
                if (storePrice.oldPrice != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    storePrice.oldPrice!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
                if (storePrice.numericOldPrice > storePrice.numericPrice) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Save ₹${(storePrice.numericOldPrice - storePrice.numericPrice).toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFE65100),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        // Delivery info
        if (storePrice.delivery != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.local_shipping, size: 14, color: Color(0xFF43A047)),
                const SizedBox(width: 4),
                Text(
                  storePrice.delivery!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF43A047),
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        // Action buttons
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: _MobileBuyButton(
                  storePrice: storePrice,
                  soldOut: soldOut,
                  hovered: _hoveredBuy,
                  onHover: (v) => setState(() => _hoveredBuy = v),
                ),
              ),
              if (storePrice.productLink.isNotEmpty) ...[
                const SizedBox(width: 8),
                _MobileViewButton(
                  storePrice: storePrice,
                  hovered: _hoveredShare,
                  onHover: (v) => setState(() => _hoveredShare = v),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _StoreLogo extends StatelessWidget {
  final StorePrice storePrice;

  const _StoreLogo({required this.storePrice});

  Color _getStoreColor(String storeName) {
    final name = storeName.toLowerCase();
    if (name.contains('flipkart')) return const Color(0xFF2874F0);
    if (name.contains('amazon')) return const Color(0xFFFF9900);
    if (name.contains('croma')) return const Color(0xFF00A650);
    if (name.contains('vijay sales') || name.contains('vijaysales')) return const Color(0xFFE91E63);
    if (name.contains('reliance digital') || name.contains('reliance')) return const Color(0xFF1976D2);
    if (name.contains('tata cliq') || name.contains('cliq')) return const Color(0xFF4CAF50);
    if (name.contains('paytm mall') || name.contains('paytm')) return const Color(0xFF00897B);
    if (name.contains('shopclues')) return const Color(0xFF7B1FA2);
    if (name.contains('snapdeal')) return const Color(0xFFD32F2F);
    if (name.contains('ebay')) return const Color(0xFF0061D8);
    if (name.contains('myntra')) return const Color(0xFFEE4C2C);
    if (name.contains('ajio')) return const Color(0xFF000000);
    if (name.contains('nykaa')) return const Color(0xFFE91E63);
    if (name.contains('bigbasket')) return const Color(0xFF2E7D32);
    if (name.contains('grofers')) return const Color(0xFF1565C0);
    if (name.contains('zomato')) return const Color(0xFFE23744);
    if (name.contains('swiggy')) return const Color(0xFFFF8800);
    
    // Generate a color based on the name hash for unknown stores
    int hash = name.hashCode.abs();
    List<Color> colors = [
      const Color(0xFF9C27B0),
      const Color(0xFF3F51B5),
      const Color(0xFF009688),
      const Color(0xFF795548),
      const Color(0xFF607D8B),
      const Color(0xFFFF5722),
      const Color(0xFFCDDC39),
      const Color(0xFF8BC34A),
    ];
    
    return colors[hash % colors.length];
  }

  Widget _buildDefaultLogo(String name, Color color) {
    // Format name to display full name with proper capitalization
    String displayName = name;
    if (name.length <= 3) {
      // For short names like "amz", convert to uppercase
      displayName = name.toUpperCase();
    } else {
      // For longer names, capitalize first letter of each word
      displayName = name.split(' ').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName,
          style: TextStyle(
            fontSize: name.length <= 3 ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = storePrice.storeName;
    final color = _getStoreColor(name);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Store icon if available
        if (storePrice.sourceIcon != null)
          Image.network(
            storePrice.sourceIcon!,
            height: 30,
            width: 80,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return _buildDefaultLogo(name, color);
            },
          )
        else
          _buildDefaultLogo(name, color),
        
        // Rating if available - from API data
        if (storePrice.rating != null) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  storePrice.rating!,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.star, size: 10, color: Colors.black87),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _CashbackColumn extends StatelessWidget {
  final StorePrice storePrice;
  const _CashbackColumn({required this.storePrice});

  @override
  Widget build(BuildContext context) {
    // // Show discount if available
    // if (storePrice.discountPercentage > 0) {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //         decoration: BoxDecoration(
    //           color: const Color(0xFFE8F5E9),
    //           borderRadius: BorderRadius.circular(4),
    //           border: Border.all(color: const Color(0xFF43A047)),
    //         ),
    //         child: const Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Icon(Icons.card_giftcard, size: 14, color: Color(0xFF43A047)),
    //             SizedBox(width: 4),
    //             Text(
    //               'Discount',
    //               style: TextStyle(
    //                 color: Color(0xFF43A047),
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: 12,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   );
    // }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${storePrice.discountPercentage.toStringAsFixed(0)}% OFF',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF212121),
              ),
            ),
            if (storePrice.oldPrice != null) ...[
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: Text(
                  storePrice.oldPrice!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF757575),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (storePrice.delivery != null) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_shipping, size: 12, color: Color(0xFF43A047)),
                const SizedBox(width: 3),
                Text(
                  storePrice.delivery!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF43A047),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        if (storePrice.reviews != null) ...[
          const SizedBox(height: 4),
          Text(
            '${storePrice.reviews} reviews',
            style: const TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
          ),
        ],
      ],
    );
  }
}

class _FinalPriceColumn extends StatelessWidget {
  final StorePrice storePrice;
  const _FinalPriceColumn({required this.storePrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF43A047),
              width: 1.5,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                storePrice.price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF43A047),
                ),
              ),
              if (storePrice.discountPercentage > 0) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_offer,
                        size: 12, color: Color(0xFF757575)),
                    const SizedBox(width: 3),
                    Text(
                      '${storePrice.discountPercentage.toStringAsFixed(0)}% OFF',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF757575),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (storePrice.numericOldPrice > storePrice.numericPrice) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.savings, size: 12, color: Color(0xFFE65100)),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Save ₹${(storePrice.numericOldPrice - storePrice.numericPrice).toStringAsFixed(0)}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFE65100),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButtonsColumn extends StatelessWidget {
  final StorePrice storePrice;
  final bool hoveredBuy;
  final bool hoveredShare;
  final ValueChanged<bool> onBuyHover;
  final ValueChanged<bool> onShareHover;

  const _ActionButtonsColumn({
    required this.storePrice,
    required this.hoveredBuy,
    required this.hoveredShare,
    required this.onBuyHover,
    required this.onShareHover,
  });

  @override
  Widget build(BuildContext context) {
    final bool soldOut = false; // TODO: Determine from API response

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Show multiple sources indicator if available
        if (storePrice.multipleSources == true) ...[
          _InfoRow(
            icon: Icons.store,
            label: 'Multiple Sources',
            iconColor: const Color(0xFF43A047),
          ),
          const SizedBox(height: 10),
        ],
        // Buy button
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => onBuyHover(true),
          onExit: (_) => onBuyHover(false),
          child: GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: soldOut
                    ? const Color(0xFF9E9E9E)
                    : const Color(0xFF1565C0)
                        .withOpacity(hoveredBuy ? 0.85 : 1.0),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'Buy Now @ ${storePrice.storeName}',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  if (!soldOut) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (storePrice.productLink.isNotEmpty) ...[
          const SizedBox(height: 8),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => onShareHover(true),
            onExit: (_) => onShareHover(false),
            child: GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF9C27B0)
                      .withOpacity(hoveredShare ? 0.85 : 1.0),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'View Product',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? highlight;
  final Color iconColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    this.highlight,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF424242))),
        if (highlight != null)
          Text(
            highlight!,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF43A047),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _MobileBuyButton extends StatelessWidget {
  final StorePrice storePrice;
  final bool soldOut;
  final bool hovered;
  final ValueChanged<bool> onHover;

  const _MobileBuyButton({
    required this.storePrice,
    required this.soldOut,
    required this.hovered,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: soldOut
                ? const Color(0xFF9E9E9E)
                : const Color(0xFF1565C0).withOpacity(hovered ? 0.85 : 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_cart, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileViewButton extends StatelessWidget {
  final StorePrice storePrice;
  final bool hovered;
  final ValueChanged<bool> onHover;

  const _MobileViewButton({
    required this.storePrice,
    required this.hovered,
    required this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF9C27B0).withOpacity(hovered ? 0.85 : 1.0),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.visibility, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
