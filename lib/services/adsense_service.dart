import 'package:cloud_firestore/cloud_firestore.dart';

class AdSenseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch AdSense configuration from Firebase
  static Future<Map<String, String>> getAdSenseConfig() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('config').doc('adsense').get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'adClient': data['adClient'] ?? 'ca-pub-XXXXXXXXXXXXXXXX',
          'adSlot': data['adSlot'] ?? 'XXXXXXXXXX',
        };
      }

      // Return default values if document doesn't exist
      return {
        'adClient': 'ca-pub-XXXXXXXXXXXXXXXX',
        'adSlot': 'XXXXXXXXXX',
      };
    } catch (e) {
      print('Error fetching AdSense config: $e');
      return {
        'adClient': 'ca-pub-XXXXXXXXXXXXXXXX',
        'adSlot': 'XXXXXXXXXX',
      };
    }
  }
}
