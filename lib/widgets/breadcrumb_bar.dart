import 'package:flutter/material.dart';

class BreadcrumbBar extends StatelessWidget {
  const BreadcrumbBar({super.key});

  @override
  Widget build(BuildContext context) {
    final crumbs = ['Home', 'Store', 'Mobiles', 'Smartphones'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          for (int i = 0; i < crumbs.length; i++) ...[
            if (i > 0)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.chevron_right, size: 14, color: Color(0xFF9E9E9E)),
              ),
            Text(
              crumbs[i],
              style: TextStyle(
                fontSize: 12,
                color: i == crumbs.length - 1
                    ? const Color(0xFF212121)
                    : const Color(0xFF1565C0),
                fontWeight: i == crumbs.length - 1
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
