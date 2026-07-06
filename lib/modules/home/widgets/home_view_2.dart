// import 'package:comparison_app/modules/home/widgets/url_search_widget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../widgets/action_buttons_row.dart';
// import '../../../widgets/breadcrumb_bar.dart';
// import '../../../widgets/price_info_bar.dart';
// import '../../../widgets/product_header.dart';
// import '../../../widgets/store_price_card.dart';
// import '../../theme/theme_controller.dart';
//
//
// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   Map<String, dynamic>? scrapedProduct;
//
//   static const _blue = Color(0xFF415FFF);
//   static const _green = Color(0xFF00C853);
//   static const _yellow = Color(0xFFFFD700);
//   static const _purple = Color(0xFFAB47BC);
//   static const _croma = Color(0xFF007A60);
//   static const _flip = Color(0xFF2874F0);
//   static const _amz = Color(0xFFFF9900);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeController = Get.find<ThemeController>();
//     final isDark = themeController.themeMode == ThemeMode.dark ||
//         (themeController.themeMode == ThemeMode.system &&
//             MediaQuery.of(context).platformBrightness == Brightness.dark);
//
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFF5F6FA),
//       body: SafeArea(
//         child: kIsWeb
//             ? PriceComparisonScreen()
//             : _buildMobileLayout(context, isDark),
//       ),
//     );
//   }
//
//   //
//   Widget _buildWebLayout(BuildContext context, bool isDark) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _webHeader(isDark),
//           _webUrlSearch(isDark),
//           if (scrapedProduct != null) _webScrapedCard(isDark),
//           _webBreadcrumb(isDark),
//           _webTitleRow(isDark),
//           _webMainContent(isDark),
//           SizedBox(height: 40.h),
//         ],
//       ),
//     );
//   }
//
//
//   Widget _webHeader(bool isDark) {
//     return Container(
//       height: 56.h,
//       padding: EdgeInsets.symmetric(horizontal: 40.w),
//       color: isDark ? const Color(0xFF16213e) : Colors.white,
//       child: Row(
//         children: [
//           Text('vivo',
//               style: TextStyle(
//                   fontSize: 26.sp,
//                   fontWeight: FontWeight.w900,
//                   fontStyle: FontStyle.italic,
//                   color: _blue)),
//           SizedBox(width: 12.w),
//           Container(width: 1, height: 20.h, color: Colors.grey[300]),
//           SizedBox(width: 12.w),
//           Text('Price Comparison',
//               style: TextStyle(
//                   fontSize: 13.sp, color: Colors.grey[500])),
//           const Spacer(),
//           // Search bar
//           Container(
//             width: 260.w,
//             height: 36.h,
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1a1a2e) : Colors.grey[100],
//               borderRadius: BorderRadius.circular(20.r),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             child: Row(
//               children: [
//                 SizedBox(width: 12.w),
//                 Icon(Icons.search, size: 16.sp, color: Colors.grey[400]),
//                 SizedBox(width: 8.w),
//                 Text('Search products...',
//                     style: TextStyle(
//                         fontSize: 12.sp, color: Colors.grey[400])),
//               ],
//             ),
//           ),
//           SizedBox(width: 16.w),
//           CircleAvatar(
//             radius: 18.r,
//             backgroundColor: _yellow,
//             child: Icon(Icons.person, size: 18.sp, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── URL Search ───────────────────────────────────────────────
//
//   Widget _webUrlSearch(bool isDark) {
//     return Container(
//       color: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFF5F6FA),
//       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
//       child: UrlSearchWidget(
//         isDark: isDark,
//         onProductScraped: (data) => setState(() => scrapedProduct = data),
//       ),
//     );
//   }
//
//   Widget _webScrapedCard(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40.w),
//       child: ScrapedProductCard(
//           productData: scrapedProduct!, isDark: isDark),
//     );
//   }
//
//   // ── Breadcrumb ───────────────────────────────────────────────
//
//   Widget _webBreadcrumb(bool isDark) {
//     final crumbs = ['Home', 'Store', 'Mobiles', 'Smartphones', 'Vivo'];
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
//       color: isDark ? const Color(0xFF16213e) : Colors.white,
//       child: Row(
//         children: [
//           for (int i = 0; i < crumbs.length; i++) ...[
//             if (i > 0)
//               Icon(Icons.chevron_right, size: 14.sp, color: Colors.grey[400]),
//             Text(
//               crumbs[i],
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 color: i == crumbs.length - 1
//                     ? (isDark ? Colors.white : Colors.black87)
//                     : Colors.grey[500],
//                 fontWeight: i == crumbs.length - 1
//                     ? FontWeight.w600
//                     : FontWeight.normal,
//               ),
//             ),
//           ]
//         ],
//       ),
//     );
//   }
//
//   // ── Product title + chips ────────────────────────────────────
//
//   Widget _webTitleRow(bool isDark) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
//       color: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFF5F6FA),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Online Price Comparison and Price History of Vivo X300 5G '
//                 '(Summit Red, 12Gb Ram, 256Gb Storage) With No Cost Emi/Additional Exchange Offers',
//             style: TextStyle(
//                 fontSize: 14.sp,
//                 color: isDark ? Colors.grey[300] : Colors.grey[700]),
//           ),
//           SizedBox(height: 10.h),
//           Row(
//             children: [
//               _chip('Ram: 12 Gb', selected: true),
//               SizedBox(width: 8.w),
//               _chip('Rom: 256 Gb', selected: true),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _chip(String label, {bool selected = false}) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
//       decoration: BoxDecoration(
//         color: selected ? const Color(0xFFE3F2FD) : Colors.transparent,
//         border: Border.all(
//             color: selected ? _blue : Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Text(label,
//           style: TextStyle(
//               fontSize: 12.sp,
//               color: selected ? _blue : Colors.grey[600],
//               fontWeight:
//               selected ? FontWeight.w600 : FontWeight.normal)),
//     );
//   }
//
//   // ── Main 2-column content ────────────────────────────────────
//
//   Widget _webMainContent(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Left column – product image card
//           SizedBox(
//             width: 280.w,
//             child: _webImageCard(isDark),
//           ),
//           SizedBox(width: 28.w),
//           // Right column – actions + price + stores
//           Expanded(child: _webRightColumn(isDark)),
//         ],
//       ),
//     );
//   }
//
//   // ── Left: Image card ─────────────────────────────────────────
//
//   Widget _webImageCard(bool isDark) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF16213e) : Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Column(
//         children: [
//           // Enlarge / Prod. Details buttons on left side
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   _iconSquareBtn(Icons.zoom_in, 'Enlarge', isDark),
//                   SizedBox(height: 10.h),
//                   _iconSquareBtn(Icons.list_alt, 'Prod.\nDetails', isDark),
//                 ],
//               ),
//               SizedBox(width: 12.w),
//               // Phone image
//               Expanded(
//                 child: AspectRatio(
//                   aspectRatio: 0.75,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.r),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             'https://via.placeholder.com/400x540/f5dede/8b4444?text=Vivo+X300'),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           // Chat / Search button top-right (decorative)
//           Align(
//             alignment: Alignment.centerRight,
//             child: Container(
//               padding:
//               EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
//               decoration: BoxDecoration(
//                 color: _yellow,
//                 borderRadius: BorderRadius.circular(20.r),
//               ),
//               child: Text('Chat / Search',
//                   style: TextStyle(
//                       fontSize: 11.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _iconSquareBtn(IconData icon, String label, bool isDark) {
//     return Container(
//       width: 52.w,
//       padding: EdgeInsets.all(8.w),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1a1a2e) : Colors.grey[100],
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: Colors.grey[300]!),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 18.sp, color: Colors.grey[600]),
//           SizedBox(height: 4.h),
//           Text(label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontSize: 10.sp, color: Colors.grey[600])),
//         ],
//       ),
//     );
//   }
//
//   // ── Right: actions + price + store comparisons ───────────────
//
//   Widget _webRightColumn(bool isDark) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _webActionButtons(),
//         SizedBox(height: 16.h),
//         _webPriceCard(isDark),
//         SizedBox(height: 16.h),
//         _webStoreList(isDark),
//       ],
//     );
//   }
//
//   Widget _webActionButtons() {
//     return Wrap(
//       spacing: 10.w,
//       runSpacing: 8.h,
//       children: [
//         _actionBtn(
//           icon: Icons.compare_arrows,
//           label: 'Comparison & Cashback',
//           bg: _green,
//           fg: Colors.white,
//         ),
//         _actionBtn(
//           icon: Icons.share,
//           label: 'Share Price Comparison & Get ₹17',
//           bg: _purple,
//           fg: Colors.white,
//         ),
//         _actionBtn(
//           icon: Icons.help_outline,
//           label: 'How Refer & Earn Works',
//           bg: Colors.transparent,
//           fg: const Color(0xFF42A5F5),
//           border: const Color(0xFF42A5F5),
//         ),
//       ],
//     );
//   }
//
//   Widget _actionBtn({
//     required IconData icon,
//     required String label,
//     required Color bg,
//     required Color fg,
//     Color? border,
//   }) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
//       decoration: BoxDecoration(
//         color: bg,
//         border: border != null ? Border.all(color: border) : null,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: fg, size: 16.sp),
//           SizedBox(width: 7.w),
//           Text(label,
//               style: TextStyle(
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.w600,
//                   color: fg)),
//         ],
//       ),
//     );
//   }
//
//   // ── Price card ───────────────────────────────────────────────
//
//   Widget _webPriceCard(bool isDark) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF16213e) : Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.circle, color: _green, size: 10.sp),
//               SizedBox(width: 6.w),
//               Text('Live! Prices Updated',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       color: _green,
//                       fontWeight: FontWeight.w600)),
//               const Spacer(),
//               Checkbox(
//                 value: false,
//                 onChanged: (_) {},
//                 materialTapTargetSize:
//                 MaterialTapTargetSize.shrinkWrap,
//               ),
//               Text('Show Images & Titles',
//                   style: TextStyle(
//                       fontSize: 12.sp, color: Colors.grey[600])),
//             ],
//           ),
//           SizedBox(height: 10.h),
//           Row(
//             children: [
//               Text("Today's Price: ",
//                   style: TextStyle(
//                       fontSize: 14.sp, color: Colors.grey[600])),
//               Text('₹75,998',
//                   style: TextStyle(
//                       fontSize: 22.sp,
//                       fontWeight: FontWeight.bold,
//                       color: _green)),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           InkWell(
//             onTap: () {},
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 18.w, vertical: 10.h),
//               decoration: BoxDecoration(
//                 color: _yellow,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.notifications_active,
//                       size: 16.sp, color: Colors.black87),
//                   SizedBox(width: 6.w),
//                   Text('Get Price Drop Alert',
//                       style: TextStyle(
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ── Store comparison list ────────────────────────────────────
//
//   Widget _webStoreList(bool isDark) {
//     final stores = [
//       _StoreData(
//         name: 'cromā',
//         color: _croma,
//         originalPrice: '₹75,999',
//         cashbackAmount: '₹185',
//         cashbackLabel: 'Cashback (T&C)',
//         finalPrice: '₹75,814',
//         afterLabel: 'After Cashback',
//         rating: null,
//         bankOffers: 1,
//         buyLabel: 'Buy Now & Get ₹185 Cb*',
//         buyColor: _yellow,
//         buyTextColor: Colors.black87,
//         shareLabel: 'Share Now & Get ₹185 Cb*',
//         shareColor: _purple,
//       ),
//       _StoreData(
//         name: 'Flipkart',
//         color: _flip,
//         originalPrice: '₹75,999',
//         cashbackAmount: '-',
//         cashbackLabel: 'Rewards',
//         finalPrice: '₹75,999',
//         afterLabel: 'Flipkart Rewards',
//         rating: '4.7',
//         bankOffers: 1,
//         buyLabel: 'Buy Now @ Flipkart →',
//         buyColor: _flip,
//         buyTextColor: Colors.white,
//         shareLabel: null,
//         shareColor: null,
//       ),
//       _StoreData(
//         name: 'amazon.in',
//         color: _amz,
//         originalPrice: '₹75,999',
//         cashbackAmount: '-',
//         cashbackLabel: 'Get Notified',
//         finalPrice: 'Sold Out',
//         afterLabel: 'Stock Back Alert',
//         rating: null,
//         bankOffers: 1,
//         buyLabel: 'Notify Me →',
//         buyColor: _amz,
//         buyTextColor: Colors.white,
//         shareLabel: null,
//         shareColor: null,
//       ),
//     ];
//
//     return Column(
//       children: stores
//           .map((s) => _webStoreCard(s, isDark))
//           .toList(),
//     );
//   }
//
//   Widget _webStoreCard(_StoreData s, bool isDark) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12.h),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF16213e) : Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           // Store name + rating
//           SizedBox(
//             width: 100.w,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(s.name,
//                     style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                         color: s.color)),
//                 if (s.rating != null)
//                   Container(
//                     margin: EdgeInsets.only(top: 4.h),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 8.w, vertical: 3.h),
//                     decoration: BoxDecoration(
//                       color: _yellow,
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Text('${s.rating} ★',
//                         style: TextStyle(
//                             fontSize: 11.sp,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.w600)),
//                   ),
//               ],
//             ),
//           ),
//
//           // Original price
//           Text(s.originalPrice,
//               style: TextStyle(
//                   fontSize: 15.sp,
//                   color:
//                   isDark ? Colors.grey[400] : Colors.grey[600])),
//           SizedBox(width: 10.w),
//           Icon(Icons.remove, size: 14.sp, color: Colors.grey[400]),
//           SizedBox(width: 10.w),
//
//           // Cashback badge
//           Container(
//             padding:
//             EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//             decoration: BoxDecoration(
//               color: _green.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(6.r),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.local_offer,
//                     size: 12.sp, color: _green),
//                 SizedBox(width: 4.w),
//                 Text('${s.cashbackAmount}  ${s.cashbackLabel}',
//                     style: TextStyle(
//                         fontSize: 11.sp, color: _green)),
//               ],
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Icon(Icons.remove, size: 14.sp, color: Colors.grey[400]),
//           SizedBox(width: 10.w),
//
//           // Final price pill
//           Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 16.w, vertical: 10.h),
//             decoration: BoxDecoration(
//               color: _green,
//               borderRadius: BorderRadius.circular(24.r),
//             ),
//             child: Column(
//               children: [
//                 Text('Grab ₹185 Cashback*',
//                     style: TextStyle(
//                         fontSize: 10.sp, color: Colors.white70)),
//                 Text(s.finalPrice,
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 Text('After ${s.afterLabel}',
//                     style: TextStyle(
//                         fontSize: 10.sp, color: Colors.white70)),
//               ],
//             ),
//           ),
//           SizedBox(width: 12.w),
//
//           // Bank offer + CTA buttons
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(Icons.account_balance,
//                       size: 13.sp, color: Colors.grey[500]),
//                   SizedBox(width: 4.w),
//                   Text('${s.bankOffers} Bank Offer',
//                       style: TextStyle(
//                           fontSize: 11.sp,
//                           color: Colors.grey[500])),
//                 ],
//               ),
//               SizedBox(height: 8.h),
//               // Buy button
//               _ctaBtn(s.buyLabel, s.buyColor, s.buyTextColor),
//               if (s.shareLabel != null) ...[
//                 SizedBox(height: 6.h),
//                 _ctaBtn(
//                     '↗ ${s.shareLabel!}',
//                     s.shareColor!,
//                     Colors.white),
//               ],
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _ctaBtn(String label, Color bg, Color fg) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         padding:
//         EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(6.r),
//         ),
//         child: Text(label,
//             style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w600,
//                 color: fg)),
//       ),
//     );
//   }
//
//   // ════════════════════════════════════════════════════════════════
//   //  MOBILE LAYOUT  (unchanged from your original)
//   // ════════════════════════════════════════════════════════════════
//
//   Widget _buildMobileLayout(BuildContext context, bool isDark) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildMobileHeader(isDark),
//           UrlSearchWidget(
//             isDark: isDark,
//             onProductScraped: (data) =>
//                 setState(() => scrapedProduct = data),
//           ),
//           if (scrapedProduct != null)
//             ScrapedProductCard(
//                 productData: scrapedProduct!, isDark: isDark),
//           _buildMobileBanner(),
//           _buildMobileProductInfo(isDark),
//           _buildMobilePriceGraph(isDark),
//           _buildMobilePriceRange(isDark),
//           _buildMobileSpecs(isDark),
//           _buildMobileActionBanner(isDark),
//           _buildMobileStoreComparisons(isDark),
//           _buildMobileJoinBanner(isDark),
//           SizedBox(height: 30.h),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileHeader(bool isDark) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF16213e) : Colors.white,
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.menu, size: 24.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               children: [
//                 Text('SuperLost',
//                     style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                         fontStyle: FontStyle.italic)),
//                 Text('#1 Online Shopping App',
//                     style: TextStyle(
//                         fontSize: 10.sp, color: Colors.grey[600])),
//               ],
//             ),
//           ),
//           Icon(Icons.search, size: 24.sp),
//           SizedBox(width: 12.w),
//           Icon(Icons.person, size: 24.sp),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileBanner() {
//     return Container(
//       margin: EdgeInsets.all(12.w),
//       padding:
//       EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFFF8E1),
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: const Color(0xFFFFD700)),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.info,
//               color: const Color(0xFFFFA000), size: 18.sp),
//           SizedBox(width: 8.w),
//           Expanded(
//             child: Text('Get Cash Now: Login > Browse > Earn > UPI',
//                 style: TextStyle(
//                     fontSize: 12.sp,
//                     color: const Color(0xFFFFA000),
//                     fontWeight: FontWeight.w500)),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 12.w, vertical: 6.h),
//             decoration: BoxDecoration(
//               color: const Color(0xFF00C853),
//               borderRadius: BorderRadius.circular(16.r),
//             ),
//             child: Text('Use App',
//                 style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileProductInfo(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.compare_arrows,
//                   size: 16.sp,
//                   color: const Color(0xFF42A5F5)),
//               SizedBox(width: 4.w),
//               Text('COMPARE PRICES',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFF42A5F5))),
//               SizedBox(width: 12.w),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 8.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color:
//                   const Color(0xFF00C853).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//                 child: Text('SAVE MAX!',
//                     style: TextStyle(
//                         fontSize: 11.sp,
//                         fontWeight: FontWeight.bold,
//                         color: const Color(0xFF00C853))),
//               ),
//               const Spacer(),
//               Icon(Icons.share,
//                   size: 20.sp, color: Colors.grey[600]),
//               SizedBox(width: 8.w),
//               Icon(Icons.list,
//                   size: 20.sp, color: Colors.grey[600]),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             'Online Price Comparison and Price History of Samsung Galaxy S23 5G AI Smartpho...',
//             style: TextStyle(
//                 fontSize: 14.sp,
//                 color: isDark
//                     ? Colors.grey[300]
//                     : Colors.grey[700]),
//           ),
//           SizedBox(height: 8.h),
//           Text('More',
//               style: TextStyle(
//                   fontSize: 12.sp,
//                   color: const Color(0xFF42A5F5),
//                   fontWeight: FontWeight.w600)),
//           SizedBox(height: 16.h),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   height: 180.h,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.r),
//                     image: const DecorationImage(
//                       image: NetworkImage(
//                           'https://via.placeholder.com/300x400/1a1a2e/FFD700?text=Galaxy+S23'),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Price History Graph',
//                         style: TextStyle(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                             color: isDark
//                                 ? Colors.grey[300]
//                                 : Colors.grey[700])),
//                     SizedBox(height: 8.h),
//                     Container(
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                         color: isDark
//                             ? const Color(0xFF16213e)
//                             : Colors.white,
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: CustomPaint(
//                         size: Size(double.infinity, 100.h),
//                         painter: PriceGraphPainter(),
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('1 Mar',
//                             style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.grey[500])),
//                         Text('1 Apr',
//                             style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.grey[500])),
//                         Text('1 May',
//                             style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.grey[500])),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             children: [
//               Text("Today's Price: ",
//                   style: TextStyle(
//                       fontSize: 14.sp,
//                       color: isDark
//                           ? Colors.grey[400]
//                           : Colors.grey[600])),
//               Text('₹37,999',
//                   style: TextStyle(
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87)),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(vertical: 12.h),
//             decoration: BoxDecoration(
//               color: const Color(0xFFCDDC39),
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.notifications,
//                     size: 18.sp, color: Colors.black87),
//                 SizedBox(width: 8.w),
//                 Text('Get Price Drop Alert',
//                     style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobilePriceGraph(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: 16.w, vertical: 16.h),
//       child: Row(
//         children: [
//           _priceTag('₹37999', '(Lowest)',
//               const Color(0xFF00C853)),
//           Expanded(
//             child: Container(
//               height: 4.h,
//               margin: EdgeInsets.symmetric(horizontal: 8.w),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFF00C853),
//                     Color(0xFFFFD700),
//                     Color(0xFFE53935)
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//             ),
//           ),
//           _priceTag('₹89999', '(Highest)',
//               const Color(0xFFE53935)),
//         ],
//       ),
//     );
//   }
//
//   Widget _priceTag(String price, String label, Color color) {
//     return Container(
//       padding:
//       EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Column(
//         children: [
//           Text(price,
//               style: TextStyle(
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white)),
//           Text(label,
//               style: TextStyle(
//                   fontSize: 10.sp, color: Colors.white70)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobilePriceRange(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.w),
//       child: Row(
//         children: [
//           _dot(const Color(0xFF00C853)),
//           Expanded(
//             child: Container(
//                 height: 4.h,
//                 color: const Color(0xFFFFD700)),
//           ),
//           _dot(const Color(0xFFE53935)),
//         ],
//       ),
//     );
//   }
//
//   Widget _dot(Color c) => Container(
//       width: 22.w,
//       height: 22.w,
//       decoration: BoxDecoration(color: c, shape: BoxShape.circle));
//
//   Widget _buildMobileSpecs(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: 16.w, vertical: 16.h),
//       child: Wrap(
//         spacing: 8.w,
//         runSpacing: 8.h,
//         children: [
//           'Ram: 8 Gb',
//           'Rom: 128 Gb',
//           'Battery: 3900 Mah',
//           'Rear Camera: 50 Mp, 10 Mp, 12 Mp',
//           'Front Camera: 12 Mp',
//         ]
//             .map((s) => Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: 12.w, vertical: 8.h),
//           decoration: BoxDecoration(
//             color: isDark
//                 ? const Color(0xFF16213e)
//                 : Colors.white,
//             border: Border.all(
//                 color: const Color(0xFF42A5F5)),
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Text(s,
//               style: TextStyle(
//                   fontSize: 12.sp,
//                   color: const Color(0xFF42A5F5))),
//         ))
//             .toList(),
//       ),
//     );
//   }
//
//   Widget _buildMobileActionBanner(bool isDark) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding:
//       EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: const Color(0xFF00C853),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.compare_arrows,
//               color: Colors.white, size: 24.sp),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Price Comparison',
//                     style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 Text('Save money by comparing prices',
//                     style: TextStyle(
//                         fontSize: 11.sp,
//                         color: Colors.white70)),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 12.w, vertical: 8.h),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.share,
//                     size: 14.sp,
//                     color: const Color(0xFF00C853)),
//                 SizedBox(width: 4.w),
//                 Text('Share & Earn',
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFF00C853))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileStoreComparisons(bool isDark) {
//     return Padding(
//       padding: EdgeInsets.all(16.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.circle,
//                   color: const Color(0xFF00C853), size: 10.sp),
//               SizedBox(width: 6.w),
//               Text('Live! Prices Updated',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       color: const Color(0xFF00C853),
//                       fontWeight: FontWeight.w500)),
//               const Spacer(),
//               Checkbox(
//                 value: false,
//                 onChanged: (_) {},
//                 materialTapTargetSize:
//                 MaterialTapTargetSize.shrinkWrap,
//               ),
//               Text('Show Images & Details',
//                   style: TextStyle(
//                       fontSize: 11.sp,
//                       color: Colors.grey[600])),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           Text('Get ₹17 Per Friend Per Order*',
//               style: TextStyle(
//                   fontSize: 12.sp,
//                   color: const Color(0xFFAB47BC))),
//           SizedBox(height: 16.h),
//           _buildMobileStoreCard(
//             storeName: 'cromā',
//             storeColor: const Color(0xFF00BFA5),
//             originalPrice: '₹44,994',
//             discount: '185',
//             cashback: '₹185',
//             finalPrice: '₹44,809',
//             isDark: isDark,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileStoreCard({
//     required String storeName,
//     required Color storeColor,
//     required String originalPrice,
//     required String discount,
//     required String cashback,
//     required String finalPrice,
//     required bool isDark,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF16213e) : Colors.white,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(storeName,
//                   style: TextStyle(
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: storeColor)),
//               const Spacer(),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 8.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF00C853).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4.r),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.local_offer,
//                         size: 12.sp,
//                         color: const Color(0xFF00C853)),
//                     SizedBox(width: 4.w),
//                     Text('Cashback',
//                         style: TextStyle(
//                             fontSize: 11.sp,
//                             color: const Color(0xFF00C853))),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   Text(originalPrice,
//                       style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: isDark
//                               ? Colors.white
//                               : Colors.black87)),
//                   Text('Extra Off* (T&C)',
//                       style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[500])),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 8.w, vertical: 4.h),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF00C853)
//                           .withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(4.r),
//                     ),
//                     child: Text('₹$discount',
//                         style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xFF00C853))),
//                   ),
//                   Icon(Icons.arrow_forward,
//                       size: 20.sp,
//                       color: Colors.grey[400]),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 10.w, vertical: 5.h),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF00C853),
//                       borderRadius: BorderRadius.circular(16.r),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.workspace_premium,
//                             size: 13.sp, color: Colors.white),
//                         SizedBox(width: 4.w),
//                         Text('For Members',
//                             style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.white70)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(finalPrice,
//                       style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFF00C853))),
//                   Text('After Cashback',
//                       style: TextStyle(
//                           fontSize: 10.sp,
//                           color: Colors.grey[500])),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileJoinBanner(bool isDark) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: const Color(0xFF00C853),
//         borderRadius: BorderRadius.circular(16.r),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(Icons.check_circle,
//                   color: Colors.white, size: 24.sp),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Text(
//                     'Join & Get ₹10, Use & Get ₹1000s',
//                     style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8.r),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Mobile Number',
//                       hintStyle: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.grey[400]),
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: 16.w),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 16.w, vertical: 12.h),
//                   decoration: BoxDecoration(
//                     color: _yellow,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(8.r),
//                       bottomRight: Radius.circular(8.r),
//                     ),
//                   ),
//                   child: Text('Join Now & Get',
//                       style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87)),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 12.h),
//           Row(
//             children: [
//               Text('Our New Members:',
//                   style: TextStyle(
//                       fontSize: 12.sp,
//                       color: Colors.white70)),
//               SizedBox(width: 8.w),
//               Icon(Icons.person,
//                   size: 16.sp, color: Colors.white),
//               Text(' Madhavi',
//                   style: TextStyle(
//                       fontSize: 12.sp, color: Colors.white)),
//               SizedBox(width: 12.w),
//               Icon(Icons.person,
//                   size: 16.sp, color: Colors.white),
//               Text(' Gautam',
//                   style: TextStyle(
//                       fontSize: 12.sp, color: Colors.white)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class _StoreData {
//   final String name;
//   final Color color;
//   final String originalPrice;
//   final String cashbackAmount;
//   final String cashbackLabel;
//   final String finalPrice;
//   final String afterLabel;
//   final String? rating;
//   final int bankOffers;
//   final String buyLabel;
//   final Color buyColor;
//   final Color buyTextColor;
//   final String? shareLabel;
//   final Color? shareColor;
//
//   const _StoreData({
//     required this.name,
//     required this.color,
//     required this.originalPrice,
//     required this.cashbackAmount,
//     required this.cashbackLabel,
//     required this.finalPrice,
//     required this.afterLabel,
//     this.rating,
//     required this.bankOffers,
//     required this.buyLabel,
//     required this.buyColor,
//     required this.buyTextColor,
//     this.shareLabel,
//     this.shareColor,
//   });
// }
//
//
// class PriceGraphPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = const Color(0xFF42A5F5)
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;
//
//     final path = Path()
//       ..moveTo(0, size.height * 0.6)
//       ..lineTo(size.width * 0.3, size.height * 0.3)
//       ..lineTo(size.width * 0.6, size.height * 0.5)
//       ..lineTo(size.width, size.height * 0.7);
//
//     canvas.drawPath(path, paint);
//
//     final dotPaint = Paint()
//       ..color = const Color(0xFF42A5F5)
//       ..style = PaintingStyle.fill;
//
//     for (final pt in [
//       Offset(0, size.height * 0.6),
//       Offset(size.width * 0.3, size.height * 0.3),
//       Offset(size.width * 0.6, size.height * 0.5),
//       Offset(size.width, size.height * 0.7),
//     ]) {
//       canvas.drawCircle(pt, 5, dotPaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter _) => false;
// }
//
// class PriceComparisonScreen extends StatefulWidget {
//   const PriceComparisonScreen({super.key});
//
//   @override
//   State<PriceComparisonScreen> createState() => _PriceComparisonScreenState();
// }
//
// class _PriceComparisonScreenState extends State<PriceComparisonScreen> {
//   String selectedRam = '12 Gb';
//   bool showImagesAndTitles = false;
//
//   final List<Map<String, dynamic>> stores = [
//     {
//       'name': 'croma',
//       'logo': 'croma',
//       'color': Color(0xFF00A650),
//       'mrp': '₹75,999',
//       'cashback': '₹185',
//       'cashbackPercent': '0%',
//       'cashbackNote': 'incl. ₹100 (New Users)*',
//       'finalPrice': '₹75,814',
//       'savings': '₹185 Savings\n(Due To Price Comparison)',
//       'buyLabel': 'Buy Now & Get ₹185 Cbk*',
//       'shareLabel': 'Share Now & Get ₹185 Cbk*',
//       'buyColor': Color(0xFFFFB300),
//       'shareColor': Color(0xFF9C27B0),
//       'soldOut': false,
//       'bankOffer': true,
//       'grabCashback': true,
//     },
//     {
//       'name': 'Flipkart',
//       'logo': 'flipkart',
//       'color': Color(0xFF2874F0),
//       'mrp': '₹75,999',
//       'cashback': null,
//       'finalPrice': '₹75,999',
//       'rewards': true,
//       'buyLabel': 'Buy Now @ Flipkart',
//       'buyColor': Color(0xFF2874F0),
//       'soldOut': false,
//       'bankOffer': false,
//       'grabCashback': false,
//     },
//     {
//       'name': 'amazon',
//       'logo': 'amazon',
//       'color': Color(0xFFFF9900),
//       'mrp': null,
//       'soldOut': true,
//       'buyLabel': 'Get Notified When Stock\'s Back',
//       'bankOffer': true,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const BreadcrumbBar(),
//             const Divider(height: 1, color: Color(0xFFE0E0E0)),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: ProductHeader(
//                       selectedRam: selectedRam,
//                       onRamChanged: (ram) => setState(() => selectedRam = ram),
//                     ),
//                   ),
//                   const SizedBox(width: 24),
//                   Expanded(
//                     flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                           const SizedBox(height: 100),
//
//                         ActionButtonsRow(),
//                         const SizedBox(height: 16),
//                         PriceInfoBar(
//                           showImagesAndTitles: showImagesAndTitles,
//                           onToggle: (val) =>
//                               setState(() => showImagesAndTitles = val),
//                         ),
//                         const SizedBox(height: 16),
//                         ...stores.map((store) => Padding(
//                           padding: const EdgeInsets.only(bottom: 2),
//                           child: StorePriceCard(store: store),
//                         )),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
