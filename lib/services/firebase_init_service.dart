import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseInitService {
  static Future<void> initializeAdSenseConfig() async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('config').doc('adsense').set({
        'adClient': 'ca-pub-3940256099942544',
        'adSlot': '1234567890',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      print('✅ AdSense configuration created in Firestore');
      print('📁 Collection: config');
      print('📄 Document: adsense');
      print('🔧 adClient: ca-pub-3940256099942544');
      print('🎯 adSlot: 1234567890');
      
    } catch (e) {
      print('❌ Error creating AdSense config: $e');
    }
  }
  
  static Future<void> testAdSenseConfig() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final doc = await firestore.collection('config').doc('adsense').get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        print('✅ AdSense config found:');
        print('🔧 adClient: ${data['adClient']}');
        print('🎯 adSlot: ${data['adSlot']}');
        print('📅 Created: ${data['createdAt']}');
      } else {
        print('❌ AdSense config not found in Firestore');
      }
    } catch (e) {
      print('❌ Error testing AdSense config: $e');
    }
  }
}
