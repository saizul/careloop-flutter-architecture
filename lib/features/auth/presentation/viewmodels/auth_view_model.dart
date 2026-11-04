import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthStateModel {
  const AuthStateModel({
    this.isLoading = false,
    this.errorMessage,
    this.verificationId,
    this.isCodeSent = false,
  });

  final bool isLoading;
  final String? errorMessage;
  final String? verificationId;
  final bool isCodeSent;

  AuthStateModel copyWith({
    bool? isLoading,
    String? errorMessage,
    String? verificationId,
    bool? isCodeSent,
  }) {
    return AuthStateModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      verificationId: verificationId ?? this.verificationId,
      isCodeSent: isCodeSent ?? this.isCodeSent,
    );
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(FirebaseAuth.instance);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

class AuthViewModel extends StateNotifier<AuthStateModel> {
  AuthViewModel(this._repository) : super(const AuthStateModel());

  final AuthRepository _repository;

  Future<bool> sendOtp(String phoneNumber) async {
    if (phoneNumber.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Phone number is required');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, isCodeSent: false);
    try {
      final verificationId = await _repository.sendOtp(phoneNumber);
      state = state.copyWith(
        isLoading: false,
        verificationId: verificationId,
        isCodeSent: true,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message ?? 'Authentication error');
      return false;
    } catch (_) {
      state = state.copyWith(isLoading: false, errorMessage: 'Failed to send OTP');
      return false;
    }
  }

  Future<UserCredential?> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    if (smsCode.trim().length != 6) {
      state = state.copyWith(errorMessage: 'Enter a valid 6-digit OTP');
      return null;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final credential = await _repository.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      state = state.copyWith(isLoading: false);
      return credential;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message ?? 'Invalid OTP');
      return null;
    } catch (_) {
      state = state.copyWith(isLoading: false, errorMessage: 'OTP verification failed');
      return null;
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthStateModel>((ref) {
  return AuthViewModel(ref.read(authRepositoryProvider));
});
