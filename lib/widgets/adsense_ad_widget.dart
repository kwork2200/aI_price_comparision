import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/adsense_service.dart';
import '../services/remote_config_service.dart';

class AdSenseAdWidget extends StatefulWidget {
  final String adSlot;
  final String adClient;
  final double? height;

  const AdSenseAdWidget({
    super.key,
    required this.adSlot,
    required this.adClient,
    this.height = 90,
  });

  @override
  State<AdSenseAdWidget> createState() => _AdSenseAdWidgetState();
}

class _AdSenseAdWidgetState extends State<AdSenseAdWidget> {
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ads_click, color: Colors.blue[700], size: 24),
            SizedBox(height: 4),
            Text(
              'Google AdSense',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Client: ${_remoteConfigService.adClient}',
              // 'Client: ${widget.adClient}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue[600], fontSize: 10),
            ),
            Text(
              'Slot: ${_remoteConfigService.adSlot}',
              // 'Slot: ${widget.adSlot}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue[600], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class AdSenseController extends GetxController {
  final adClient = 'ca-pub-XXXXXXXXXXXXXXXX'.obs;
  final adSlot = 'XXXXXXXXXX'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAdSenseConfig();
  }

  Future<void> _loadAdSenseConfig() async {
    try {
      final config = await AdSenseService.getAdSenseConfig();
      adClient.value = config['adClient']!;
      adSlot.value = config['adSlot']!;
    } catch (e) {
      print('Error loading AdSense config: $e');
    }
  }
}


