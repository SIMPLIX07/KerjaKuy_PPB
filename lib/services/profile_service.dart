import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileService {
  static final _db = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  static Future<void> createProfile({
    required int userId,
    required String username,
    required String fullname,
    required String jobTitle,
  }) async {
    await _db.collection('profiles').doc(userId.toString()).set({
      'userId': userId,
      'username': username,
      'fullname': fullname,
      'jobTitle': jobTitle,
      'photoUrl': '',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<DocumentSnapshot> getProfile(int userId) async {
    return await _db.collection('profiles').doc(userId.toString()).get();
  }

  static Future<void> updatePhoto(int userId, String photoUrl) async {
    await _db.collection('profiles').doc(userId.toString()).update({
      'photoUrl': photoUrl,
    });
  }

  static Future<String> uploadProfilePhoto({
    required int userId,
    required File file,
  }) async {
    final ref = _storage
        .ref()
        .child('profile_images')
        .child('user_$userId.jpg');

    await ref.putFile(file);

    final downloadUrl = await ref.getDownloadURL();

    await _db.collection('profiles').doc(userId.toString()).update({
      'photoUrl': downloadUrl,
    });

    return downloadUrl;
  }
}
