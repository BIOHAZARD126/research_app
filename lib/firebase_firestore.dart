import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserData(String userId, Map<String, dynamic> data) {
    return _db.collection('users').doc(userId).set(data);
  }

  Future<DocumentSnapshot> getUserData(String userId) {
    return _db.collection('users').doc(userId).get();
  }

  // Add other Firestore operations as needed
}
