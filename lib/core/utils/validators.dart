class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final normalized = value.replaceAll(RegExp(r'[^0-9+]'), '');
    if (normalized.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
