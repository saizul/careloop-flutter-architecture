import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../widgets/app_primary_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../viewmodels/auth_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final vm = ref.read(authViewModelProvider.notifier);
    final phone = _phoneController.text.trim();
    final ok = await vm.sendOtp(phone);
    if (!mounted || !ok) {
      return;
    }
    context.go(
      AppRoutes.otp,
      extra: <String, dynamic>{
        'phoneNumber': phone,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);
    final error = state.errorMessage;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Continue with phone',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text('Use country code format, e.g. +8801XXXXXXXXX'),
                const SizedBox(height: 24),
                AppTextField(
                  controller: _phoneController,
                  labelText: 'Phone number',
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),
                const SizedBox(height: 16),
                if (error != null) ...[
                  Text(
                    error,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const SizedBox(height: 10),
                ],
                AppPrimaryButton(
                  label: 'Continue',
                  isLoading: state.isLoading,
                  onPressed: _continue,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go(AppRoutes.registration),
                  child: const Text('Create new account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
