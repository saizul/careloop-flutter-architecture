import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../widgets/app_primary_button.dart';
import '../viewmodels/auth_view_model.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({
    required this.phoneNumber,
    this.fullName,
    this.age,
    this.gender,
    this.userType,
    super.key,
  });

  final String phoneNumber;
  final String? fullName;
  final int? age;
  final String? gender;
  final String? userType;

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    final otp = _otpController.text.trim();
    if (otp.length != 6) {
      ref.read(authViewModelProvider.notifier).clearError();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid 6-digit OTP')),
      );
      return;
    }

    final authState = ref.read(authViewModelProvider);
    final verificationId = authState.verificationId;
    if (verificationId == null || verificationId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification session expired. Retry login.')),
      );
      return;
    }

    final credential = await ref.read(authViewModelProvider.notifier).verifyOtp(
          verificationId: verificationId,
          smsCode: otp,
        );
    if (!mounted || credential == null) {
      return;
    }

    await _upsertProfile(credential.user);

    if (!mounted) {
      return;
    }
    final role = (widget.userType ?? 'Patient').toLowerCase();
    if (role == 'doctor') {
      context.go(AppRoutes.doctor);
    } else {
      context.go(AppRoutes.patient);
    }
  }

  Future<void> _upsertProfile(User? user) async {
    if (user == null) {
      return;
    }
    final doc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final snapshot = await doc.get();
    final now = FieldValue.serverTimestamp();
    if (snapshot.exists) {
      await doc.set({'lastLoginAt': now}, SetOptions(merge: true));
      return;
    }
    await doc.set({
      'uid': user.uid,
      'phoneNumber': widget.phoneNumber,
      'fullName': widget.fullName,
      'age': widget.age,
      'gender': widget.gender,
      'userType': widget.userType ?? 'Patient',
      'createdAt': now,
      'lastLoginAt': now,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Code sent to ${widget.phoneNumber}'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: 'Enter 6-digit OTP',
                  counterText: '',
                ),
              ),
              const SizedBox(height: 12),
              if (state.errorMessage != null) ...[
                Text(
                  state.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                const SizedBox(height: 10),
              ],
              AppPrimaryButton(
                label: 'Verify',
                isLoading: state.isLoading,
                onPressed: _verify,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final ok = await ref
                            .read(authViewModelProvider.notifier)
                            .sendOtp(widget.phoneNumber);
                        if (!mounted || !ok) {
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OTP resent')),
                        );
                      },
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
