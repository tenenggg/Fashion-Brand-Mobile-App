import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up
  Future<UserModel?> signUp({
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      // Create user model
      UserModel userModel = UserModel(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(userModel.uid).set(userModel.toMap());

      return userModel;
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  // Update User Profile
  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      final Map<String, dynamic> updates = {};
      if (name != null) updates['name'] = name;
      if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;
      if (address != null) updates['address'] = address;

      await _firestore.collection('users').doc(uid).update(updates);
    } catch (e) {
      print('Update profile error: $e');
      rethrow;
    }
  }

  // Get User Profile
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      print('Get profile error: $e');
      rethrow;
    }
    return null;
  }

  // Reset Password (this method is not applicable without authentication)
  Future<void> resetPassword(String email) async {
    throw UnimplementedError('Reset password is not applicable without authentication.');
  }

  Future<bool> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Update last login time
        await _firestore.collection('users').doc(userCredential.user!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'uid': userCredential.user!.uid,
        });
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print('Registration error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error during registration: $e');
      return false;
    }
  }
}
