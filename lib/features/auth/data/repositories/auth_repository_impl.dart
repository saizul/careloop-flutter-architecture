import 'package:firebase_auth/firebase_auth.dart';

import '../datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<String> sendOtp(String phoneNumber) async {
    return _remoteDataSource.sendOtp(phoneNumber);
  }

  @override
  Future<UserCredential> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    return _remoteDataSource.verifyOtp(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
