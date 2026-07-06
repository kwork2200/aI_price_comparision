// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../services/remote_config_service.dart';
//
// class RemoteConfigDemoPage extends StatefulWidget {
//   const RemoteConfigDemoPage({super.key});
//
//   @override
//   State<RemoteConfigDemoPage> createState() => _RemoteConfigDemoPageState();
// }
//
// class _RemoteConfigDemoPageState extends State<RemoteConfigDemoPage> {
//   final RemoteConfigService _remoteConfigService = RemoteConfigService();
//
//   @override
//   Widget build(BuildContext context) {
//
//     // floatingActionButton: FloatingActionButton(
//     //   onPressed: () => Get.toNamed(Routes.REMOTE_CONFIG_DEMO),
//     //   backgroundColor: const Color(0xFF1565C0),
//     //   tooltip: 'Remote Config Demo',
//     //   child: const Icon(Icons.settings_remote, color: Colors.white),
//     // ),
//     //
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             SizedBox(height: 16),
//             Expanded(
//               child: ListView(
//                 children: [
//                   _buildConfigItem('adClient', _remoteConfigService.adClient),
//                   _buildConfigItem('adSlot', _remoteConfigService.adSlot),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 await _remoteConfigService.refresh();
//                 setState(() {});
//                 Get.snackbar(
//                   'Success',
//                   'Remote Config values refreshed!',
//                   backgroundColor: Colors.green,
//                   colorText: Colors.white,
//                 );
//               },
//               child: Text('Refresh Remote Config'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildConfigItem(String label, String value) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       child: ListTile(
//         title: Text(label),
//         subtitle: Text(value),
//       ),
//     );
//   }
// }
