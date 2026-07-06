import 'package:flutter/material.dart';

class PriceInfoBar extends StatelessWidget {
  final bool showImagesAndTitles;
  final ValueChanged<bool> onToggle;

  const PriceInfoBar({
    super.key,
    required this.showImagesAndTitles,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: isMobile 
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with live indicator and checkbox
              Row(
                children: [
                  // Live prices badge
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF43A047),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Live! Prices Updated',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF43A047),
                    ),
                  ),
                  const Spacer(),
                  // Show images checkbox
                  GestureDetector(
                    onTap: () => onToggle(!showImagesAndTitles),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF9E9E9E), width: 1.5),
                            borderRadius: BorderRadius.circular(3),
                            color: showImagesAndTitles
                                ? const Color(0xFF1565C0)
                                : Colors.white,
                          ),
                          child: showImagesAndTitles
                              ? const Icon(Icons.check, size: 11, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Show Images',
                          style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Bottom row with price and button
              Row(
                children: [
                  // Today's price
                  const Text(
                    "Today's Price: ",
                    style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
                  ),
                  const Text(
                    '₹75,998',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE53935),
                    ),
                  ),
                  const Spacer(),
                  // Get Price Drop Alert button
                  _PriceDropButton(isMobile: true),
                ],
              ),
            ],
          )
        : Row(
            children: [
              // Live prices badge
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF43A047),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Live! Prices Updated',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF43A047),
                ),
              ),
              const SizedBox(width: 20),
              // Show images checkbox
              GestureDetector(
                onTap: () => onToggle(!showImagesAndTitles),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF9E9E9E), width: 1.5),
                        borderRadius: BorderRadius.circular(3),
                        color: showImagesAndTitles
                            ? const Color(0xFF1565C0)
                            : Colors.white,
                      ),
                      child: showImagesAndTitles
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
              const Spacer(),
              // Today's price
              const Text(
                "Today's Price: ",
                style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
              ),
              const Text(
                '₹75,998',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFE53935),
                ),
              ),
              const SizedBox(width: 16),
              // Get Price Drop Alert button
              _PriceDropButton(),
            ],
          ),
    );
  }
}

class _PriceDropButton extends StatefulWidget {
  final bool isMobile;
  
  const _PriceDropButton({this.isMobile = false});

  @override
  State<_PriceDropButton> createState() => _PriceDropButtonState();
}

class _PriceDropButtonState extends State<_PriceDropButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 10 : 14, 
            vertical: widget.isMobile ? 6 : 9
          ),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF2E7D32) : const Color(0xFF43A047),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.notifications_active, 
                color: Colors.white, 
                size: widget.isMobile ? 14 : 16
              ),
              SizedBox(width: widget.isMobile ? 4 : 6),
              Text(
                widget.isMobile ? 'Price Alert' : 'Get Price Drop Alert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.isMobile ? 11 : 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
