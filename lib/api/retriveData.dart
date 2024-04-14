import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makaihealth/utility/logger.dart';

Future<Map<String, dynamic>?> retrieveData(String mobileNumber,String collectionName) async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(mobileNumber)
        .get();
    if (snapshot.exists) {
      snapshot.data()!.logD;
      return snapshot.data() as Map<String, dynamic>;
    } else {
      ('No data found for mobile number: $mobileNumber').logD;
      return null;
    }
  } catch (e) {
    ('Error retrieving data: $e').logD;
    return null;
  }
}