import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../widgets/app_primary_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../viewmodels/auth_view_model.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  String _gender = 'Male';
  String _userType = 'Patient';

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
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
        'fullName': _fullNameController.text.trim(),
        'age': int.tryParse(_ageController.text.trim()),
        'gender': _gender,
        'userType': _userType,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: _fullNameController,
                  labelText: 'Full name',
                  validator: (value) => Validators.required(value, fieldName: 'Full name'),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _ageController,
                  labelText: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final base = Validators.required(value, fieldName: 'Age');
                    if (base != null) {
                      return base;
                    }
                    final age = int.tryParse(value!.trim());
                    if (age == null || age < 1 || age > 120) {
                      return 'Enter valid age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _gender,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _gender = value);
                    }
                  },
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: _phoneController,
                  labelText: 'Phone number',
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _userType,
                  decoration: const InputDecoration(labelText: 'User type'),
                  items: const [
                    DropdownMenuItem(value: 'Patient', child: Text('Patient')),
                    DropdownMenuItem(value: 'Doctor', child: Text('Doctor')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _userType = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                if (state.errorMessage != null) ...[
                  Text(
                    state.errorMessage!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const SizedBox(height: 10),
                ],
                AppPrimaryButton(
                  label: 'Continue',
                  isLoading: state.isLoading,
                  onPressed: _continue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
