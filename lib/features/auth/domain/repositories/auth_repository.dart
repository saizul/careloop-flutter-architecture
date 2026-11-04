import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<String> sendOtp(String phoneNumber);
  Future<UserCredential> verifyOtp({
    required String verificationId,
    required String smsCode,
  });
  Future<void> signOut();
}
